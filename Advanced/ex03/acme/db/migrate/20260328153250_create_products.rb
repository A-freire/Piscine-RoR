class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0
      t.references :brand, null: false, foreign_key: true
      t.string :pict

      t.timestamps
    end
  end
end
