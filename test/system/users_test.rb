require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_1)
    sign_in @user
  end

  test "visiting user show page" do
    visit user_url(@user)
    assert_selector "h1", text: @user.name
  end

  # test "visiting the index" do
  #   visit users_url
  #
  #   assert_selector "h1", text: "User"
  # end
end
