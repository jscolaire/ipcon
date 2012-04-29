class DelActivoToActivo < ActiveRecord::Migration
  def self.up
    remove_column :activos, :activo_id
  end

  def self.down
    add_column :activos, :activo_id, :integer
  end
end
