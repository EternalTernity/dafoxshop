class AddFirstNameAndLastNameAndPhoneNumberAndEmailToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone_number, :integer
    add_column :orders, :email, :string
  end
end
