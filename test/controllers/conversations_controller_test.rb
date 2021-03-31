require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conversation = conversations(:one)
    users(:user_1).photo.attach(io: File.open('db/files/IMG_7772.JPG'), filename: 'IMG_7772.JPG')
    users(:user_2).photo.attach(io: File.open('db/files/IMG_7772.JPG'), filename: 'IMG_7772.JPG')
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

    assert_redirected_to friendship_conversation_url(Conversation.last.friendship, Conversation.last)
  end

  test "should show conversation" do
    get conversation_url(@conversation)
    assert_response :success
  end

  test "should get edit" do
    get edit_conversation_url(@conversation)
    assert_response :success
  end

  test "should update conversation" do
    patch conversation_url(@conversation), params: { conversation: { user_id: @conversation.user_id } }
    assert_redirected_to conversation_url(@conversation)
  end

  test "should destroy conversation" do
    assert_difference('Conversation.count', -1) do
      delete conversation_url(@conversation)
    end

    assert_redirected_to conversations_url
  end
end
