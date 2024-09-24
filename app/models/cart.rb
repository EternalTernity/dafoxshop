class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items
  has_many :products, through: :cart_items

  def total
    cart_items.sum { |item| item.product.price * item.quantity }
  end
end
