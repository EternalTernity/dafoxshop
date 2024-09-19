class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :likes
  has_many :replies

  validates :star_rating, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :subject, presence: true
  validates :content, presence: true

  scope :is_published, -> { where(is_published: true) }
end
