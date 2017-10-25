class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images do |t|
      t.references :product, foreign_key: true
      t.string :title
      t.string :url
      t.text :desc
      t.string :caption
      t.string :alt

      t.timestamps
    end
  end
end
