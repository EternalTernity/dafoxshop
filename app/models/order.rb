class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items
  has_many :products, through: :order_items

  validates :city, :province, :barangay, :zip_code, :street, :house_number, presence: true
  validates :first_name, :last_name, :email, presence: true, unless: -> { user.present? }
  before_create :generate_token

  def total
    order_items.collect { |ci| ci.quantity.nil? ? (ci.quantity*ci.price):0.0 }.sum
  end

  def generate_token
    self.token=SecureRandom.hex(50) if token.blank?
  end
end
