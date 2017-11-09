class AddMenuOrderToFields < ActiveRecord::Migration[5.1]
  def change
    add_column :fields, :menu_order, :integer
  end
end
