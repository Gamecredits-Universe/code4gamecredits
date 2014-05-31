class Distribution < ActiveRecord::Base
  belongs_to :project, inverse_of: :distributions
  has_many :tips
  accepts_nested_attributes_for :tips

  scope :to_send, -> { where(txid: nil) }
  scope :error, -> { where(is_error: true) }

  def sent?
    sent_at or txid
  end

  def total_amount
    tips.map(&:amount).compact.sum
  end

  def send_transaction!
    Distribution.transaction do
      lock!
      raise "Already sent" if sent?
      raise "Transaction already sent and failed" if is_error?
      raise "Project disabled" if project.disabled?

      update!(sent_at: Time.now, is_error: true) # it's a lock to prevent duplicates
    end

    data = generate_data
    update_attribute(:data, data)

    raise "Not enough funds on Distribution##{id}" if total_amount > project.available_amount

    txid = BitcoinDaemon.instance.send_many(project.address_label, JSON.parse(data))

    update!(txid: txid, is_error: false)
  end

  def generate_data
    outs = Hash.new { 0.to_d }
    tips.each do |tip|
      outs[tip.user.bitcoin_address] += tip.amount.to_d / COIN
    end
    outs.to_json
  end

  def all_addresses_known?
    tips.all? { |tip| tip.user.try(:bitcoin_address).present? }
  end

  def can_be_sent?
    !sent? and all_addresses_known?
  end
end
