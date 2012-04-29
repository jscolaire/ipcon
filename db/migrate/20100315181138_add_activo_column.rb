class AddActivoColumn < ActiveRecord::Migration
  def self.up
    add_column :ips, :activo_id, :integer
  end

  def self.down
    remove_column :ips, :activo_id
  end
end
