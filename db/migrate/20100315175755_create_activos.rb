class CreateActivos < ActiveRecord::Migration
  def self.up
    create_table :activos do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :activos
  end
end
