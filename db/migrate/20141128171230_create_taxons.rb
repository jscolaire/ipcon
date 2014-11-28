class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.string :name
      t.integer :taxon_id
      t.integer :taxontype_id

      t.timestamps
    end
  end
end
