class Sendmany < ActiveRecord::Base
  belongs_to :project

  def send_transaction
    return if txid || is_error

    update_attribute :is_error, true # it's a lock to prevent duplicates

    txid = PeercoinDaemon.instance.send_many(project.address_label, JSON.parse(data))

    update_attribute :is_error, false
    update_attribute :txid, txid
  end
end
