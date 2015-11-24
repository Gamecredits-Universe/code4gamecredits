class InitializeProjectAddressLabel < ActiveRecord::Migration
  def up
    execute "UPDATE projects SET address_label=(full_name || '@code4gamecredits') WHERE address_label IS NULL"
  end
end
