class AccountsController < ApplicationController
  def details
    @user=current_user
    @options = %w[Account Address Orders Wishlist]
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

  private
  def update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end
