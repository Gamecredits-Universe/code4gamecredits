class CreateColdStorageTransfers < ActiveRecord::Migration
  def change
    create_table :cold_storage_transfers do |t|
      t.belongs_to :project, index: true
      t.integer :amount, limit: 8
      t.string :address
      t.string :txid
      t.integer :confirmations

      t.timestamps
    end
  end
end
