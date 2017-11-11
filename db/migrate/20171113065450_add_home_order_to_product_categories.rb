class AddHomeOrderToProductCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :product_categories, :home_order, :integer
  end
end
