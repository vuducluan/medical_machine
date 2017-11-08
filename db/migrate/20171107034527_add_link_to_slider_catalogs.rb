class AddLinkToSliderCatalogs < ActiveRecord::Migration[5.1]
  def change
    add_column :slider_catalogs, :link, :string
  end
end
