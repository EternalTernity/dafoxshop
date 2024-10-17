class Category < ApplicationRecord
  has_many :products
  has_one_attached :category_avatar
  validates :name, presence: true
  belongs_to :parent_category, class_name: "Category", optional: true
end
