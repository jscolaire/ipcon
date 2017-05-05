class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.string :name
      t.integer :taxon_id, :default => -1
      t.integer :taxontype_id, :default => -1

      t.timestamps
    end
  end
end
