class AddDisabledToProject < ActiveRecord::Migration
  def change
    add_column :projects, :disabled, :boolean, default: false
  end
end
