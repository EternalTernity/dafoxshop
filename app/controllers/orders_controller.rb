class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [ :show ], unless: -> { params[:email].present? }
  before_action :check_total_price, only: [ :new ]
  def new
    @order=Order.new
    @show_password=false
  end

  def create
    if User.exists?(email: order_params[:email])
      puts "email already exists, displaying the field..."
      @show_password=true # fix this
      render :new and return
    end

    @order=user_signed_in? ? current_user.orders.new(order_params) : Order.new(order_params)

    current_cart.cart_items.each do |ci|
      @order.order_items.build(product: ci.product, quantity: ci.quantity.to_i)
    end

    @order.email ||= current_user&.email
    @order.total=current_cart.total

    if @order.save

      current_cart.cart_items.destroy_all
      if user_signed_in?
        redirect_to order_path(@order.token)
      else
        redirect_to guest_order_path(@order.token, email: @order.email)
      end
    else
      redirect_to root_path
    end
  end

  def check_total_price
    if current_cart.total.zero?
      flash[:error]="You have no orders, redirecting to your carts"
      puts "You have no orders, redirecting to your carts"
      redirect_to cart_path
    end
  end
  def show
    if user_signed_in?
      @order=current_user.orders.find_by(token: params[:id])
    else
      @order=Order.find_by(token: params[:id])
      unless @order&.email == params[:email]
        redirect_to root_path
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :city, :province, :barangay, :zip_code, :street, :house_number, :first_name, :last_name, :phone_number, :email, :password)
  end
end
