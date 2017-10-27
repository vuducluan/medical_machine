class RemoveImageFromMedium < ActiveRecord::Migration[5.1]
  def change
    remove_column :media, :image, :string
  end
end
