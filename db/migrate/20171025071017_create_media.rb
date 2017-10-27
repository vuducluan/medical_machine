class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :url
      t.integer :media_type
      t.integer :field_id

      t.timestamps
    end
  end
end
