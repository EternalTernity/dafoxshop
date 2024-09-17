class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items
  before_save :update_total

  def total
    cart_items.collect { |ci| !ci.quantity.nil? ? (ci.quantity*ci.price):0 }.sum
  end

  private
  def update_total
    self[:total]=total
  end
end
