class CartsController < ApplicationController
  after_action :send_email, only: [ :add_to_cart ]
  def add_to_cart
    product=Product.find_by(slug: params[:product_id])
    quantity=params[:quantity].to_i
    cart_item=current_cart.cart_items.find_by(product: product)

    if cart_item
      cart_item.update(quantity: cart_item.quantity + quantity)
    else
      current_cart.cart_items.create(product: product, quantity: quantity, price: product.price)
    end

    redirect_to cart_path, notice: "You added a cart."
  end

  def remove_from_cart
    cart_item=current_cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path
  end

  def show
    @cart=current_cart
  end

  def add_quantity
    cart_item=current_cart.cart_items.find(params[:id])
    cart_item.update(quantity: cart_item.quantity + 1)
    redirect_to cart_path
  end

  def reduce_quantity
    cart_item=current_cart.cart_items.find(params[:id])
    if cart_item.quantity > 1
      cart_item.update(quantity: cart_item.quantity - 1)
      redirect_to cart_path
    else
      cart_item.destroy
      redirect_to cart_path
    end
  end

  def clear_all_carts
    current_cart.cart_items.destroy_all
    redirect_to root_path
  end

  def send_email
    UserMailer.welcome.deliver_now
  end
end
