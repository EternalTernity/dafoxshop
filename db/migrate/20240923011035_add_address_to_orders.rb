class AddAddressToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :city, :string
    add_column :orders, :province, :string
    add_column :orders, :barangay, :string
    add_column :orders, :zip_code, :integer
    add_column :orders, :street, :string
    add_column :orders, :house_number, :string
  end
end
