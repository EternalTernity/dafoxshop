class CartsController < ApplicationController
  before_action :authenticate_user!, only: [ :add_to_cart ]

  def new
    if current_user.cart.present?
      redirect_to cart_path(current_user)
    else
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
      cart_item.quantity += params[:quantity].to_i if params[:quantity].nil?
      cart_item.assign_attributes(price: @product.price)
      cart_item.save!
    end

    redirect_to product_path(@product), notice: "You have added to a cart"
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
      redirect_to @cart
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
    
    if @cart_item
      @cart_item.increment(:quantity)
    else
      @cart.cart_items.build(product_id: @product.id, quantity: 1)
    end

    @cart_item.save
    redirect_to cart_path(@cart)
  end

  def reduce_quantity
    @cart=current_user.cart
    @product=Product.find_by(id: params[:product_id])
    @cart_item=@cart.cart_items.find_or_initialize_by(product: @product)

    if @cart_item
      @cart_item.decrement(:quantity)
      @cart_item.save
      @cart_item.destroy if @cart_item.quantity <= 0
    end
    redirect_to cart_path(@cart)
  end

  def clear_all_carts
    current_user.cart.cart_items.destroy_all
    redirect_to root_path
  end
end
