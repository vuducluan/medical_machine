class AddParameterToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :parameter, :text
  end
end
