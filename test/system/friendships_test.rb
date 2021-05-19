require "application_system_test_case"

class FriendshipsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @friendship = friendships(:one)
    @user = users(:user_1)
    @friend= users(:user_3)

    log_in @user
  end

  test "visiting the index" do
    visit friendships_url
    assert_selector "h1", text: "Friendships"
  end

  test "creating a Friendship" do
    assert_nil Friendship.find_by(user: @user, friend: @friend)
    visit user_url(@friend) 

    click_on "Add friend"

    assert_text "Yay! Now you are friends."
  end

  test "destroying a Friendship" do
    visit friendships_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Friendship was successfully destroyed"
  end
end
