class Sendmany < ActiveRecord::Base
  belongs_to :project
  has_many :tips

  def total_amount
    JSON.parse(data).values.map(&:to_d).sum if data
  end

  def send_transaction
    return if txid || is_error

    update_attribute :is_error, true # it's a lock to prevent duplicates

    raise "Not enough funds on Sendmany##{id}" if total_amount > project.available_amount

    txid = PeercoinDaemon.instance.send_many(project.address_label, JSON.parse(data))

    update_attribute :is_error, false
    update_attribute :txid, txid
  end
end
