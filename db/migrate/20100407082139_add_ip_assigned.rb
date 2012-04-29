class AddIpAssigned < ActiveRecord::Migration
  def self.up
    add_column :ips, :assigned, :boolean, :default => false

    #Ip.update_all('assigned =  0')
    #Ip.update_all('assigned = 1',["gw = ?",true])
  end

  def self.down
    remove_column :ips, :assigned
  end
end
