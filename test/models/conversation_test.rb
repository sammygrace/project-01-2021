require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  setup do
    @conversation = conversations(:one)
  end

  test "all conversations should have a friendship" do
    Conversation.all.each do |conversation|
      assert_not_nil conversation.friendship
    end
  end

  test "messages should delete with conversation" do
    assert_difference("Message.count", -@conversation.messages.count) do
      @conversation.destroy
    end
  end
end
