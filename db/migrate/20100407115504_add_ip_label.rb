class AddIpLabel < ActiveRecord::Migration
  def self.up
    add_column :ips, :label, :string
  end

  def self.down
    remove_column :ips, :label
  end
end
