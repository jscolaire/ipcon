class CreateTaxontypes < ActiveRecord::Migration
  def change
    create_table :taxontypes do |t|

      t.string :name

      t.timestamps
    end
  end
end
