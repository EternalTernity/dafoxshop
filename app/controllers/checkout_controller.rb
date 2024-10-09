class CheckoutController < ApplicationController
  def create
    product = Product.find_by(id: params[:id])
    @session = Stripe::Checkout::Session.create({
                                                 ui_mode: "embedded",
                                                 line_items: [ {
                                                                name: product.name,
                                                                price: product.price,
                                                                quantity: 1,
                                                                currency: "php",
                                                              } ],
                                                 mode: "payment",
                                                 return_url: root_path,
                                               })
    respond_to do |format|
      format.js
    end
  end
end