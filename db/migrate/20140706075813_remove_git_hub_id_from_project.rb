class RemoveGitHubIdFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :github_id, :string
  end
end
