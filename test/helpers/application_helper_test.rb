class ApplicationHelperTest < ActionView::TestCase
  include CanCan::Ability

  setup do
    @user = nil
    @post = posts(:one)
  end

  test "should not be displayed if user not signed in" do
    assert hidden_if_no_user(@user) == "display: none"
  end

  test "hidden if user is unauthorized to manage" do
    ability = Ability.new(@user)
    assert_not ability.can?(:manage, @post)
    assert hidden_if_unauthorized_to_manage(@post) == "display: none"
  end

  test "hidden if user is owner of post" do
    user1 = users(:user_1)
    assert hidden_if_owner_of_post(user1, user1.posts.first) == "display: none"
  end

  test "hidden if user is owner of profile" do
    user1 = users(:user_1)
    assert hidden_if_owner_of_profile(user1, User.find_by(id: user1.id)) == "display: none"
  end

  test "pagy navs for short lists are hidden" do
    posts = Post.all[0..9]
    assert hidden_for_short_lists(posts) == "display: none"
  end
end

