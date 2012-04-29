class CreateActivoTags < ActiveRecord::Migration
  def self.up
    create_table :activo_tags do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :activo_tags
  end
end
