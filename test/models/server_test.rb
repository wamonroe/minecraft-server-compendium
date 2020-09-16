require 'test_helper'

class ServerTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_length_of(:name).is_at_most(32)
  should validate_uniqueness_of(:name)
  should validate_length_of(:description).is_at_most(256)
  should validate_presence_of(:hostname)
  should validate_presence_of(:port)
  should validate_numericality_of(:port).only_integer.
    is_greater_than(0).is_less_than_or_equal_to(65_535)

  should belong_to(:user).optional
  should have_many(:locations).dependent(:destroy)

  should have_db_index(:user_id)
  should have_db_index(:name).unique

  context '#default_port?' do
    should 'return true when port 25_565' do
      subject.port = 25_565
      assert subject.default_port?
    end

    should 'return false when port not 25_565' do
      subject.port = 25_566
      assert_not subject.default_port?
    end
  end
end
