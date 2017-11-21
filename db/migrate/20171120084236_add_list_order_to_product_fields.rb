class AddListOrderToProductFields < ActiveRecord::Migration[5.1]
  def change
    add_column :product_fields, :list_order, :integer
  end
end
