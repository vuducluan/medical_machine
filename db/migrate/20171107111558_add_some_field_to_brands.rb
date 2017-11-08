class AddSomeFieldToBrands < ActiveRecord::Migration[5.1]
  def change
    add_column :brands, :home_order, :integer
    add_column :brands, :image, :string
  end
end
