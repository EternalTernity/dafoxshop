class AccountsController < ApplicationController
  before_action :authenticate_user!
  def details
    @user=current_user

    @options = %w[Account Address Orders Wishlist]
    @wishlists=current_user.wishlists
    @orders=current_user.orders
    @addresses=@orders.map(&:address)
  end
  def edit
    @user=current_user
  end
  def update_password
    @user=current_user
    if @user.update_with_password(update_params)
      bypass_sign_in(@user)
      redirect_to root_path
    else
      redirect_to edit_account_path
    end
  end

  def create
    product=Product.friendly.find(params[:id])
    wishlist=current_user.wishlists.find_by(product: product)

    if wishlist
      redirect_to product_path(product)
    else
      wishlist=current_user.wishlists.build(product: product)
      if wishlist.save
        redirect_to collections_adopisoft_path
      else
        redirect_to root_path
      end
    end
  end

  def destroy
    wishlist=current_user.wishlists.find_by(product_id: params[:product_id])
    if wishlist
      wishlist.destroy
      redirect_to wishlist_account_path
    else
      redirect_to root_path
    end
  end
  private
  def update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end
