class RenameSendmanyToDistribution < ActiveRecord::Migration
  def change
    rename_table :sendmanies, :distributions
    rename_column :tips, :sendmany_id, :distribution_id
  end
end
