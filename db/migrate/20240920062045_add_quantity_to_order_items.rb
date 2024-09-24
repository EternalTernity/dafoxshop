class AddQuantityToOrderItems < ActiveRecord::Migration[7.2]
  def change
    add_column :order_items, :quantity, :integer
  end
end
