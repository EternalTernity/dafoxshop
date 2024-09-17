class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.string :created_by_id
      t.string :slug, index: true

      t.timestamps
    end
  end
end
