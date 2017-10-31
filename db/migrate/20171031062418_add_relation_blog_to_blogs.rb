class AddRelationBlogToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :relation_blog_id_1, :integer
    add_column :blogs, :relation_blog_id_2, :integer
  end
end
