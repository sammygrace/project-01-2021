require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conversation = conversations(:one)
    attach_photo users(:user_1)
    attach_photo users(:user_2)
  end

  test "should get index" do
    get conversations_url
    assert_response :success
  end

  test "should get new" do
    get new_conversation_url
    assert_response :success
  end

  test "should create conversation" do
    assert_difference('Conversation.count') do
      post conversations_url, 
        params: { conversation: { user_id: @conversation.user_id, friend_id: @conversation.friend_id, friendship_id: @conversation.friendship_id } }
    end

    assert_redirected_to conversation_url(Conversation.last)
  end

  test "should show conversation" do
    get conversation_url(@conversation)
    assert_response :success, "conversation not showing"
  end

  test "should destroy conversation" do
    assert_difference('Conversation.count', -1) do
      delete conversation_url(@conversation)
    end

    assert_redirected_to conversations_url
  end
end
