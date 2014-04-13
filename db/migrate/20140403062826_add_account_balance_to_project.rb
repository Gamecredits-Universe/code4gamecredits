class AddAccountBalanceToProject < ActiveRecord::Migration
  def change
    add_column :projects, :account_balance, :integer, limit: 8
  end
end
