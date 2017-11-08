class AddHomeBlockIdAndHomeOrderIdToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :home_block_id, :integer
    add_column :categories, :home_order_id, :integer
  end
end
