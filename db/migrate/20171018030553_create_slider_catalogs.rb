class CreateSliderCatalogs < ActiveRecord::Migration[5.1]
  def change
    create_table :slider_catalogs do |t|
      t.string :title
      t.string :url
      t.text :desc
      t.text :caption
      t.text :alt
      t.string :image_type

      t.timestamps
    end
  end
end
