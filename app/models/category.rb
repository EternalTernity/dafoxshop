class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true
  belongs_to :parent_category, class_name: "Category", optional: true
end
