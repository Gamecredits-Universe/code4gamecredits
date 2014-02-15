class AddAddresLabelToProject < ActiveRecord::Migration
  def change
    add_column :projects, :address_label, :string
  end
end
