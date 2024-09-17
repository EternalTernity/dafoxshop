class Product < ApplicationRecord
  has_one_attached :product_image
  has_many :cart_items
  has_many :carts, through: :cart_items

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_many :reviews

  def image_webp
    product_image.variant(format: "webp")
  end
end
