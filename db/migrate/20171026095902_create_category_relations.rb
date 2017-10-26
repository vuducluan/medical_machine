class CreateCategoryRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :category_relations do |t|
      t.integer :parent_id
      t.integer :children_id

      t.timestamps
    end
  end
end
