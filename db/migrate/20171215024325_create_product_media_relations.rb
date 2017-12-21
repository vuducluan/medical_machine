class CreateProductMediaRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_media_relations do |t|
      t.references :product, foreign_key: true
      t.references :medium, foreign_key: true

      t.timestamps
    end
  end
end
