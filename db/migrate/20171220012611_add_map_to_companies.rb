class AddMapToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :map_lat, :float
    add_column :companies, :map_lng, :float
  end
end
