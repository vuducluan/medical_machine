class AddColumnsToSubcriber < ActiveRecord::Migration[5.1]
  def change
    add_column :subcribers, :full_name, :string
    add_column :subcribers, :title, :string
    add_column :subcribers, :phone, :string
    add_column :subcribers, :content, :text
  end
end
