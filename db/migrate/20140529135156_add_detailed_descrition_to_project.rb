class AddDetailedDescritionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :detailed_description, :text
  end
end
