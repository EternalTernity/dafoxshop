class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one :cart
  has_many :orders
  has_one_attached :avatar
  has_many :reviews
  has_many :likes
  has_many :replies

  after_initialize :set_default_role, if: :new_record?

  enum role: [ :user, :moderator, :admin ]
  def set_default_role
    self.role ||= :user
  end

  def image_webp
    avatar.variant(format: "webp")
  end

end
