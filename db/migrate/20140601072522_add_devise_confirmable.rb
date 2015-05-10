class AddDeviseConfirmable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email
    end

    # Existing users with a GitHub nickname are confirmed
    execute "UPDATE users SET confirmed_at='#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}' WHERE nickname IS NOT NULL"
  end
end
