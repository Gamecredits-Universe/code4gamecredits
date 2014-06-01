class RemoveUniqueConstraintToProjectFullName < ActiveRecord::Migration
  def up
    remove_index "projects", "full_name"
  end

  def down
    add_index "projects", ["full_name"], name: "index_projects_on_full_name", unique: true
  end
end
