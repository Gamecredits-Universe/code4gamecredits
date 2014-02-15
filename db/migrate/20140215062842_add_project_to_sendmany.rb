class AddProjectToSendmany < ActiveRecord::Migration
  def change
    add_column :sendmanies, :project_id, :integer
    add_index :sendmanies, :project_id
  end
end
