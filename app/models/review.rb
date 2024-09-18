class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :star_rating, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :subject, presence: true
  validates :content, presence: true

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_role
    self.is_published||="pending"
  end
end
