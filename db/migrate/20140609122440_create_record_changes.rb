class CreateRecordChanges < ActiveRecord::Migration
  def change
    create_table :record_changes do |t|
      t.belongs_to :record, index: true, polymorphic: true
      t.belongs_to :user
      t.text :raw_state, limit: 1.megabyte

      t.timestamps
    end
  end
end
