class User < ApplicationRecord
  # Include devise modules, :registerable and :omniauthable are also available.
  devise :database_authenticatable, :confirmable, :invitable, :lockable, :recoverable,
    :rememberable, :timeoutable, :trackable, :validatable

  validates :name, presence: true
  validates :username, presence: true, length: { minimum: 3, maximum: 16 },
    format: { with: /\A[A-Za-z0-9_-]+\z/, message: 'only letters, numbers, underscore, or dash' },
    uniqueness: true

  has_many :server, dependent: :nullify
  has_many :locations, dependent: :nullify
end
