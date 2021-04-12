require "application_system_test_case"

class ConversationsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @conversation = conversations(:one)
    @author = users(:user_2)
    @friend = users(:user_3)

    sign_in @author
  end

  test "visiting the index" do
    visit conversations_url
    assert_selector "h1", text: "Conversations"
  end

  test "creating a Conversation" do
    friendship = @author.friendships_as_user.find_by(friend: @friend) || @author.friendships_as_friend.find_by(user: @author)
    assert_not_nil friendship
    assert_nil Conversation.find_by(author: friendship.user, friend: friendship.friend, friendship: friendship)

    visit user_url(@friend)

    click_on "Start Conversation with #{@friend.name}"

    assert_text "Conversation was successfully created."
  end

  test "destroying a Conversation" do
    visit conversations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Conversation was successfully destroyed"
  end
end
