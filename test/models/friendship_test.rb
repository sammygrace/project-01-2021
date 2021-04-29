require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  setup do
    @friendship = friendships(:one)
    @conversation = @friendship.conversation
  end

  test "all friendships should have user and friend" do
    Friendship.all.each do |friendship|
      assert_not_nil friendship.user
      assert_not_nil friendship.friend
    end
  end

  test "conversation should be destroyed with friendship" do
    assert_difference("Conversation.count", -1) do
      @friendship.destroy
    end
  end
end
