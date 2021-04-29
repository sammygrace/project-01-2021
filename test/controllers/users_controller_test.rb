require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_1)
    sign_in @user
  end

  test "should show user" do
    get user_path(@user)
    assert_response :success
  end
end
