require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  test "all friendships should have user and friend" do
    Friendship.all.each do |friendship|
      assert_not_nil friendship.user
      assert_not_nil friendship.friend
    end
  end
end
