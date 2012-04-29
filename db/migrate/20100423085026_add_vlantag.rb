class AddVlantag < ActiveRecord::Migration
  def self.up
    add_column :networks, :vlan_id, :integer
  end

  def self.down
    remove_column :networks, :vlan_id
  end
end
