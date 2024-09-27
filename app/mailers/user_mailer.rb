class UserMailer < ApplicationMailer
  def welcome
    mail(
      to: "ariana@grande.com",
      subject: "hi invited you to view this product."
    )
  end
end
