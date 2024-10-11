class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.decimal :total
      t.string :country
      t.string :city
      t.string :province
      t.timestamps
    end
  end
end
