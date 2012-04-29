class CreateIps < ActiveRecord::Migration
  def self.up
    create_table :ips do |t|
      t.integer :network_id
      t.string :ip
      t.string :hostname
      t.boolean :gw
      t.boolean :enabled
      t.boolean :reserved

      t.timestamps
    end

  end

  def self.down
    drop_table :ips
  end
end
