class AddHomeOrderToSliderCatalogs < ActiveRecord::Migration[5.1]
  def change
    add_column :slider_catalogs, :home_order, :integer
  end
end
