require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    assert_routing "/", controller: "welcome", action: "index"
    get root_path
    assert_response :success
  end
end
