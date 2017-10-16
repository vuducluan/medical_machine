class RenameOrderFromCategories < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :order, :category_order
  end
end
