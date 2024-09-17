class CartsController < ApplicationController
  before_action :authenticate_user!, only: [ :add_to_cart ]

  def new
    # if the current user has cart
    if current_user.cart.present?
      redirect_to cart_path(current_user)
    else
      # create a cart for the the current user
      @cart=current_user.build_cart
      if @cart.save
        redirect_to cart_path(current_user.cart)
      end
    end
  end

  def add_to_cart
    @product=Product.find_by(id: params[:product_id])

    if @product
      @cart=current_user.cart||current_user.build_cart
      cart_item=@cart.cart_items.find_or_initialize_by(product: @product)
      cart_item.assign_attributes(price: @product.price)
      cart_item.save!
    end

    redirect_to carts_path, notice: "You have added to a cart"
  end

  def remove_from_cart
    @cart=current_user.cart
    @product=Product.find_by(id: params[:product_id])
    @cart_item=@cart.cart_items.find_by(product: @product)

    if @cart_item
      @cart_item.destroy
      if @cart.cart_items.empty?
        redirect_to root_path, notice: "Your cart is empty."
      else
        redirect_to cart_path(current_user.cart), notice: "You have removed a product from cart."
      end
    else
      redirect_to @cart, notice: "It's an error while removing a cart, try again."
    end
  end

  def show
    if current_user.nil?
      redirect_to new_user_session_path
    else
      @cart=current_user.cart || current_user.build_cart
      @product=Product.find_by(id: params[:id])
      @cart_items=@cart.cart_items

      if @cart_items.empty?
        redirect_to root_path
      end
    end
  end

  def add_quantity
    @cart=current_user.cart
    @product=Product.find_by(id: params[:product_id])
    @cart_item=@cart.cart_items.find_or_initialize_by(product: @product)
    new_quantity=@cart_item.quantity.to_i + 1

    if @cart_item.update(quantity: new_quantity)
      redirect_to cart_path(@cart)
    else
      redirect_to cart_path(@cart)
    end
  end

  def reduce_quantity
    @cart=current_user.cart
    @product=Product.find_by(id: params[:product_id])
    @cart_item=@cart.cart_items.find_or_initialize_by(product: @product)
    @cart_item.quantity = [ 0, @cart_item.quantity - 1 ].max
    redirect_to cart_path(@cart) if @cart_item.update(quantity: @cart_item.quantity)
    @cart_item.destroy if @cart_item.quantity <= 0
  end

  def clear_all_carts
    current_user.cart.cart_items.destroy_all
    redirect_to root_path
  end
end
