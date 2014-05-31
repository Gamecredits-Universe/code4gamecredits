class AddSentAtToDistribution < ActiveRecord::Migration
  def change
    add_column :distributions, :sent_at, :datetime
  end
end
