class WelcomeHelperTest < ActionView::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_1)
  end

  test "should hide if user signed in" do
    assert hidden_when_signed_in(@user) == "display: none"
  end
end

