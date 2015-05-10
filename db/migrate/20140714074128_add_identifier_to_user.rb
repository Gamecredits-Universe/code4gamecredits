class AddIdentifierToUser < ActiveRecord::Migration
  def up
    add_column :users, :identifier, :string
    execute("SELECT id FROM users WHERE identifier IS NULL").each do |row|
      id = row["id"]
      charset = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'.split(//)
      identifier = (0...12).map { charset.sample }.join
      execute "UPDATE users SET identifier='#{identifier}' WHERE id = #{id}"
    end
    change_column :users, :identifier, :string, null: false
    add_index :users, :identifier, unique: true
  end

  def down
    remove_column :users, :identifier
  end
end
