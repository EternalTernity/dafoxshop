class AddTokenToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :token, :string
  end
end
