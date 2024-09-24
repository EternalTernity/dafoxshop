class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.belongs_to :user, foreign_key: true
      t.decimal :total

      t.timestamps
    end
  end
end
