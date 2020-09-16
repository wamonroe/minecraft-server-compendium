require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_length_of(:name).is_at_most(32)
  should validate_uniqueness_of(:name).scoped_to(:server_id)
  should validate_presence_of(:dimension)
  should validate_length_of(:description).is_at_most(256)
  should validate_inclusion_of(:dimension).in_array(Location.dimensions.keys)
  should validate_presence_of(:x)
  should validate_numericality_of(:x).only_integer
  should validate_presence_of(:y)
  should validate_numericality_of(:y).only_integer
  should validate_presence_of(:z)
  should validate_numericality_of(:z).only_integer

  should belong_to(:server).counter_cache
  should belong_to(:user).optional

  should have_db_index(:server_id)
  should have_db_index(:user_id)
  should have_db_index(%i[server_id name]).unique

  context '#dimension=' do
    should 'sets the value when provided a valid key' do
      value = Location.dimensions.keys.first
      subject.dimension = value
      assert_equal value, subject.dimension
    end

    should 'set the value to nil when provided an invalid key' do
      subject.dimension = 'abcdefg'
      assert_nil subject.dimension
    end
  end
end
