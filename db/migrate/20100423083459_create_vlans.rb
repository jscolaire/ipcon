class CreateVlans < ActiveRecord::Migration
  def self.up
    create_table :vlans do |t|
      t.integer :tag
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :vlans
  end
end
