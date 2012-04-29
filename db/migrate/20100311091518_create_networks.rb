class CreateNetworks < ActiveRecord::Migration
  def self.up
    create_table :networks do |t|
      t.integer :gw_id
      t.string  :prefix
      t.integer :network
      t.integer :netmask
      t.integer :first
      t.integer :last
      t.integer :bcast
      t.integer :hosts
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :networks
  end
end
