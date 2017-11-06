class AddIsParameterTableToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :is_parameter_table, :boolean
  end
end
