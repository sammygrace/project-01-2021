require 'test_helper'

class ConversationFlowTest < ActionDispatch::IntegrationTest
  setup do
    @friendship_without_conv = friendships(:two)
    @user = @friendship_without_conv.user
    @friend = @friendship_without_conv.friend
    
    sign_in @user
  end

  test "should redirect to friendship conversation after creating" do
    post conversations_url, params: { conversation: { friendship_id: @friendship_without_conv.id, friend_id: @friend.id, user_id: @user.id } }

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "p.notice", "Conversation was successfully created."

    assert_select "h4" do
      assert_select "strong", "Author:"
      assert_select "a", @user.name
      assert_select "strong", "Friend:"
      assert_select "a", @friend.name
    end
  end
end
