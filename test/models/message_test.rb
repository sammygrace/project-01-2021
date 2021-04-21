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
end
