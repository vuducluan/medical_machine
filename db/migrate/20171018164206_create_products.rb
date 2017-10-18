class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :name
      t.text :model
      t.integer :brand_id
      t.string :location
      t.integer :price
      t.integer :discount_price
      t.integer :product_category_id
      t.string :product_type
      t.text :description
      t.integer :product_field_id
      t.string :label
      t.integer :label_order
      t.integer :category_order

      t.timestamps
    end
  end
end
