class DropVersion < ActiveRecord::Migration
  def change
    drop_table :versions
  end

  def down
    create_table "versions", force: true do |t|
      t.string   "item_type",      null: false
      t.integer  "item_id",        null: false
      t.string   "event",          null: false
      t.string   "whodunnit"
      t.text     "object"
      t.datetime "created_at"
      t.text     "object_changes"
    end

    add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end
end
