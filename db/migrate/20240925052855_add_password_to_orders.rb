class AddPasswordToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :password, :string
  end
end
