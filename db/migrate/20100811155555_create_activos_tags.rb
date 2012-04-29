class CreateActivosTags < ActiveRecord::Migration
  def self.up
    create_table :activos_tags, :id => false do |t|
      t.integer :activo_id
      t.integer :tag_id
    end

  end

  def self.down
    drop_table :activos_tags
  end
end
