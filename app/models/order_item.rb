class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_one_attached :order_image

  def subtotal
    product.price * quantity
  end
end
