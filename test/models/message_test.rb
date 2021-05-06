require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @message = messages(:one)
  end

  test "should not create blank message" do
    new_message = Message.new(content: "", conversation: @message.conversation, user: @message.user)
    assert_not new_message.save, "user can create message without any visible content"
  end

  test "should belong to a user and a conversation" do
    Message.all.each do |message|
      assert_not_nil message.user
      assert_not_nil message.conversation
    end
  end

  test "should not create message for other users' conversations" do
    @uninvited_user = users(:user_5)
    conversation = Conversation.where.not("friend_id = ? and user_id = ?", @uninvited_user.id, @uninvited_user.id).first
    message = @uninvited_user.messages.new(conversation: conversation, content: "hi")
    sign_in @uninvited_user

    ability = Ability.new(@univited_user)
    assert_not ability.can?(:create, conversation.messages.new(content: message.content))
  end
end
