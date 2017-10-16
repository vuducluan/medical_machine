class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.references :template
      t.text :content
      t.boolean :is_important, default: false
      t.references :blog_category

      t.timestamps
    end
  end
end
