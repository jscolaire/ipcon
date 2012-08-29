class AddIpGw < ActiveRecord::Migration
  def up
    add_column :ips, :gw_id, :integer
  end

  def down
    remove_column :ips, :gw_id
  end
end
