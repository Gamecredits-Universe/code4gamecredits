class AddDonationAddressToDeposit < ActiveRecord::Migration
  def change
    add_reference :deposits, :donation_address, index: true
  end
end
