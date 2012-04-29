class AddHpsrp < ActiveRecord::Migration
  def self.up
    add_column :ips, :hpsrp, :boolean    
  end

  def self.down
    remove_column :ips, :hpsrp
  end
end
