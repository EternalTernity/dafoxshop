class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  has_one_attached :product_image

  def image_webp
    product_image.variant(format: "webp")
  end

  def subtotal
    if self.price && self.quantity
      self.subtotal=self.price*self.quantity
    else
      self.subtotal=0.0
    end
  end
end
