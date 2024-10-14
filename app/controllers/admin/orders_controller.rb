class Admin::OrdersController < AdminController
  def index
    @orders = Order.all
    @order_items = OrderItem.all
  end
end