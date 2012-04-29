class AddIpTemporal < ActiveRecord::Migration
  def self.up
    add_column :ips, :temporal, :boolean 
  end

  def self.down
    remove_column :ips, :temporal
  end
end
