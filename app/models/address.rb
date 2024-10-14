
class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :zip_code, :street, :house_number, presence: true
end
