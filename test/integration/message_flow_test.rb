require 'test_helper'

class MessageFlowTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
    @conversation = @message.conversation
    @user = @conversation.author
    @friend = @conversation.friend

    attach_photo(@user)
    attach_photo(@friend)

    sign_in @user
  end

  test "should redirect to conversation after creating" do
    get new_message_path
    post messages_path, params: { message: { user_id: @message.user_id, content: @message.content, conversation_id: @message.conversation_id } }

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "h4" do
      assert_select "strong", "Author:"
      assert_select "a", @user.name
    end

    assert_select "h4" do
      assert_select "strong", "Author:"
      assert_select "a", @user.name
    end

    assert_select "p#notice", "Message sent!"
    assert_select "div#msg-content", @message.content
  end
end
