class Location < ApplicationRecord
  enum dimension: { overworld: 0, nether: 1, end: 2 }, _prefix: true

  validates :name, presence: true, length: { maximum: 32 }, uniqueness: { scope: :server_id }
  validates :description, length: { maximum: 256 }
  validates :dimension, presence: true, inclusion: { in: dimensions.keys }
  validates :x, presence: true, numericality: { only_integer: true }
  validates :y, presence: true, numericality: { only_integer: true }
  validates :z, presence: true, numericality: { only_integer: true }

  belongs_to :server, counter_cache: true
  belongs_to :user, optional: true

  def dimension=(value)
    super(value)
  rescue ArgumentError
    super(nil)
  end
end
