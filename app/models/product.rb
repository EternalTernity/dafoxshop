class Product < ApplicationRecord
  has_one_attached :product_image
  has_many_attached :product_variants

  has_many :cart_items
  has_many :carts, through: :cart_items

  has_many :order_items

  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate :num_of_images

  has_many :reviews

  extend FriendlyId
  friendly_id :name, use: :slugged

  def image_webp
    product_image.variant(format: "webp")
  end

  def to_param
    slug
  end

  def average_rating
    return 0 if reviews.empty?
    reviews.average(:star_rating).to_f.round(1)
  end

  def num_of_images
    if product_variants.attached? && product_variants.count>3
      errors.add(:product_images, "Upload atleast 3 images.")
    end
  end
end
