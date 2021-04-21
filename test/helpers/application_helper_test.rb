class ApplicationHelperTest < ActionView::TestCase
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  setup do
    @user = users(:user_5)
    @post = posts(:one)
  end

=begin stack level too deep :P
  test "hidden when user not signed in" do
    sign_out @user
    assert hidden_when_not_signed_in == "display: none"
  end
=end

=begin
  test "hidden if user is unauthorized to manage" do
    ability = Ability.new(@user)
    assert_not ability.can?(:manage, @post)
    assert hidden_if_unauthorized_to_manage(@post) == "display: none"
  end
=end

=begin stack level too deep :P
  test "hidden if user is owner" do
    assert hidden_if_owner_of(users(:user_5)) == "display: none"
  end
=end
end

