class NewDefaultToHoldTips < ActiveRecord::Migration
  def change
    change_column :projects, :hold_tips, :boolean, default: true
  end
end
