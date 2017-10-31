class AddProductIdToMedium < ActiveRecord::Migration[5.1]
  def change
    add_column :media, :product_id, :integer
  end
end
