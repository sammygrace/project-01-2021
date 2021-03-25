require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
    @conversation = @message.conversation
    @user = users(:one)
  end

  test "should get index" do
    get messages_url
    assert_response :success
  end

  test "should get new" do
    get new_message_url
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post messages_url, params: { message: { content: @message.content, conversation_id: @message.conversation_id, user_id: @message.user_id } }
    end

    assert_redirected_to conversation_url(Message.last.conversation)
  end
end
