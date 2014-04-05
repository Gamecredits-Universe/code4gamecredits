class AddDisabledReasonToProject < ActiveRecord::Migration
  def change
    add_column :projects, :disabled_reason, :string
  end
end
