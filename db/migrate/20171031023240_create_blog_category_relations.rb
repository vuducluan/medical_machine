class CreateBlogCategoryRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_category_relations do |t|
      t.references :blog, foreign_key: true
      t.references :blog_category, foreign_key: true

      t.timestamps
    end
  end
end
