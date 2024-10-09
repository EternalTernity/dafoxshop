class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items
  has_many :products, through: :order_items

  validates :zip_code, :street, :house_number, presence: true
  validates :country, presence: true
  validates :province, inclusion: { in: ->(record) { record.provinces.keys }, allow_blank: true },
             presence: { if: ->(record) { record.provinces.present? } }
  validates :city, presence: { if: ->(record) { record.cities.present? } }
  validates :first_name, :last_name, :email, presence: true, unless: -> { user.present? }
  before_create :generate_token

  def total
    order_items.sum { |item| item.product.price * item.quantity }
  end

  def countries
    CS.countries.with_indifferent_access
  end

  def provinces
    CS.states(country).with_indifferent_access
  end

  def cities
    CS.cities(province, country)||[]
  end

  private
  def generate_token
    self.token=SecureRandom.hex(50) if token.blank?
  end
end
