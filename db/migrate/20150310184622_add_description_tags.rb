class AddDescriptionTags < ActiveRecord::Migration
  def up
    add_column :tags, :description, :string
  end

  def down
    remove_column :tags, :description
  end
end
