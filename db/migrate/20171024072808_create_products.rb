class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :brand, foreign_key: true
      t.references :label, foreign_key: true
      t.string :name
      t.string :model
      t.string :location
      t.integer :price
      t.integer :discount_price
      t.string :product_type
      t.text :description
      t.string :short_description
      t.integer :label_order
      t.integer :category_order

      t.timestamps
    end
  end
end
