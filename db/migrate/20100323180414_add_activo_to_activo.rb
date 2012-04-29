class AddActivoToActivo < ActiveRecord::Migration
  def self.up
    add_column :activos, :activo_id, :integer
  end

  def self.down
    remove_column :activos, :activo_id
  end
end
