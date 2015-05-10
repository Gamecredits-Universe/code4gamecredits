class AddOriginToTip < ActiveRecord::Migration
  def change
    add_reference :tips, :origin, index: true, polymorphic: true
  end
end
