class AddColdStorageWithdrawalAddressToProject < ActiveRecord::Migration
  def change
    add_column :projects, :cold_storage_withdrawal_address, :string
  end
end
