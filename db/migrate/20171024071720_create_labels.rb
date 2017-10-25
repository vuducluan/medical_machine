class CreateLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :labels do |t|
      t.string :title
      t.string :short_title
      t.integer :block_order

      t.timestamps
    end
  end
end
