class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart
  has_many :reviews
  after_initialize :set_default_role, if: :new_record?
  enum role: [ :user, :moderator, :admin ]
  def set_default_role
    self.role ||= :user
  end
end
