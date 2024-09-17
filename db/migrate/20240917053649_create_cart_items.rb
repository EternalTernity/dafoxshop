class CreateCartItems < ActiveRecord::Migration[7.2]
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.decimal :subtotal
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
