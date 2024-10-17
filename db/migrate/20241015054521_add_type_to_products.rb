class AddTypeToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :type, :string
  end
end
