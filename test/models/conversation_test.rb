require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  setup do
    @conversation = conversations(:one)
    @user = users(:user_5)

    sign_in @user
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

  test "should not be able to see other users' conversations" do
    ability = Ability.new(@user)
    conversation = Conversation.where.not("friend_id = ? and user_id = ?", @user.id, @user.id).first
    assert_not ability.can?(:read, conversation)
  end
end
