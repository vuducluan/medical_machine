class AddHomeOrderToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :home_order, :integer
  end
end
