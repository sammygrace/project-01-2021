require 'test_helper'

class FriendshipFlowTest < ActionDispatch::IntegrationTest
  setup do 
    @friendship = friendships(:two)
    @user = @friendship.user
    @friend = @friendship.friend

    sign_in @user
  end

  test "should redirect to friend profile after creating" do
    get user_url(@friend)
    assert_select "form input", { :value => "Add Friend" }

    post friendships_url, params: { friendship: { friend_id: @friend.id, user_id: @user.id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert body =~ /#{@friend.id}/
    assert_select "h1", @friend.name
    assert_select "form input", { :value => "Start Conversation with #{@friend.name}" }
  end
end
