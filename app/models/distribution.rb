class Distribution < ActiveRecord::Base
  belongs_to :project, inverse_of: :distributions
  has_many :tips
  accepts_nested_attributes_for :tips

  scope :to_send, -> { where(txid: nil) }
  scope :error, -> { where(is_error: true) }

  def sent?
    !!txid
  end

  def total_amount
    JSON.parse(data).values.map(&:to_d).sum if data
  end

  def send_transaction!
    Distribution.transaction do
      lock!
      return if sent?
      return if is_error?
      return if project.disabled?

      update_attribute :is_error, true # it's a lock to prevent duplicates
    end

    data = generate_data
    update_attribute(:data, data)

    raise "Not enough funds on Distribution##{id}" if total_amount > project.available_amount

    txid = BitcoinDaemon.instance.send_many(project.address_label, JSON.parse(data))

    update_attribute :txid, txid
    update_attribute :is_error, false
  end

  def generate_data
    outs = Hash.new { 0.to_d }
    tips.each do |tip|
      outs[tip.user.bitcoin_address] += tip.amount.to_d / COIN
    end
    outs.to_json
  end
end
