class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  def new
    @order=Order.new
  end

  def create
    @order=user_signed_in? ? current_user.orders.new(order_params) : Order.new(order_params)

    current_cart.cart_items.each do |ci|
      @order.order_items.build(product: ci.product, quantity: ci.quantity.to_i)
    end
    @order.total=current_cart.total
    if @order.save
      current_cart.cart_items.destroy_all
      if user_signed_in?
        redirect_to order_path(@order.token)
      else
        redirect_to guest_order(@order, email: @order.email)
      end
    else
      redirect_to root_path
    end
  end

  def show
    if user_signed_in?
      @order=current_user.orders.find_by(token: params[:id])
    else
      @order=Order.find(params[:id])
      unless @order.email == params[:email]
        redirect_to root_path
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :city, :province, :barangay, :zip_code, :street, :house_number, :first_name, :last_name, :phone_number, :email)
  end
end
