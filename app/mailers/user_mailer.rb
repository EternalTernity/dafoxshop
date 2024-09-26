class UserMailer < ApplicationMailer
  def welcome(user, token, product)
    @user=user
    @token=token
    @product=product
    mail(
      to: @user.email,
      subject: "hi invited you to view this product."
    )
  end
end
