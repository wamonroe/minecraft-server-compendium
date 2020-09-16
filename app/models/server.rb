class Server < ApplicationRecord
  validates :name, presence: true, length: { maximum: 32 }, uniqueness: true
  validates :description, length: { maximum: 256 }
  validates :hostname, presence: true
  validates :port, presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 65_535 }

  belongs_to :user, optional: true
  has_many :locations, dependent: :destroy

  def default_port?
    port == 25_565
  end
end
