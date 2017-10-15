class RenameDescFromBlogImages < ActiveRecord::Migration[5.1]
  def change
    rename_column :blog_images, :desc, :description
  end
end
