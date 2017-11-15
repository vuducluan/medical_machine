class AddListOrderToProductCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :product_categories, :list_order, :integer
  end
end
