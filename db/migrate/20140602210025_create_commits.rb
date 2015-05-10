class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.belongs_to :project, index: true
      t.string :sha
      t.text :message
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
