class AddIsServiceToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :is_service, :boolean
  end
end
