class CreateProductFields < ActiveRecord::Migration[5.1]
  def change
    create_table :product_fields do |t|
      t.references :product, foreign_key: true
      t.references :field, foreign_key: true

      t.timestamps
    end
  end
end
