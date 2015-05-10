class RenameOriginToReason < ActiveRecord::Migration
  def change
    rename_column :tips, :origin_type, :reason_type
    rename_column :tips, :origin_id, :reason_id
  end
end
