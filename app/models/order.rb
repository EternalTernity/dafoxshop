class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items
  has_many :products, through: :order_items

  validates :zip_code, :street, :house_number, presence: true
  validates :province, presence: true
  validates :city, presence: { if: ->(record) { record.states.present? } }
  validates :barangay,  presence: { if: ->(record) { record.cities.present? } }
  validates :first_name, :last_name, :email, presence: true, unless: -> { user.present? }
  before_create :generate_token

  def total
    order_items.sum { |item| item.product.price * item.quantity }
  end

  def countries
    Luzvimin.regions
  end

  def states
    Luzvimin.region(province).provinces
  end

  def cities
    Luzvimin.region(province).province(city).cities
  end

  def country_name
    countries[country]
  end

  def state_name
    states[state]
  end

  private
  def generate_token
    self.token=SecureRandom.hex(50) if token.blank?
  end
end
