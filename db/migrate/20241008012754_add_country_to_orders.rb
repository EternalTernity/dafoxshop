class AddCountryToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :country, :string
  end
end
