class AddDescriptionToFields < ActiveRecord::Migration[5.1]
  def change
    add_column :fields, :description, :text
  end
end
