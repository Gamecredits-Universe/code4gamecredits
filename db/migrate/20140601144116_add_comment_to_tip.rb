class AddCommentToTip < ActiveRecord::Migration
  def change
    add_column :tips, :comment, :string
  end
end
