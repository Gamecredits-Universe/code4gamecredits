class AddFeeToSendmany < ActiveRecord::Migration
  def change
    add_column :sendmanies, :fee, :integer
  end
end
