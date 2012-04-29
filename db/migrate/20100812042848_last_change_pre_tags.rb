class LastChangePreTags < ActiveRecord::Migration
  def self.up
    remove_column :activos, :description
    rename_column :activos, :tag, :description
    change_column :activos, :description, :string, :limit => 255    
  end

  def self.down
    rename_column :activos, :description, :tag
    add_column  :activos, :description, :text
  end
end
