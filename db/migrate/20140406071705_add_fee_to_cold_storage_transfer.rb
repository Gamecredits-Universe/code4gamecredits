class AddFeeToColdStorageTransfer < ActiveRecord::Migration
  def change
    add_column :cold_storage_transfers, :fee, :integer
  end
end
