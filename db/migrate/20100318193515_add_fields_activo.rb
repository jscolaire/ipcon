class AddFieldsActivo < ActiveRecord::Migration
  def self.up   
   add_column :activos, :tag, :string, :limit => 50 
   add_column :activos, :os, :string
  end

  def self.down 
    remove_column :activos, :tag
    remove_column :activos, :os
  end
end
