class CreateBlogImages < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_images do |t|
      t.string :title
      t.string :url
      t.text :desc
      t.string :caption
      t.string :alt
      t.references :blog, foreign_key: true
      t.boolean :is_feature

      t.timestamps
    end
  end
end
