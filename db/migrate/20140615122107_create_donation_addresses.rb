class CreateDonationAddresses < ActiveRecord::Migration
  def change
    create_table :donation_addresses do |t|
      t.belongs_to :project, index: true
      t.string :sender_address
      t.string :donation_address

      t.timestamps
    end
  end
end
