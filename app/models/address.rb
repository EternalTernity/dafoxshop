
class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true

  validates :zip_code, :street, :house_number, presence: true
end
