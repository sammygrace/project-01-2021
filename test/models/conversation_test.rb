require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  test "all conversations should have a friendship" do
    Conversation.all.each do |conversation|
      assert_not_nil conversation.friendship
    end
  end
end
