class AccountsController < ApplicationController
  def details
    @user=current_user
    @options = [
      "Account",
      "Address",
      "Orders",
      "Wishlist"
    ]
  end
end
