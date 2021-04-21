class PostsHelperTest < ActionView::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_5)
    @likes = @user.likes
    @post = posts(:one)

    sign_in @user
  end

  test "partial 'like post' renders if user has not liked post" do
    assert_not @likes.find_by(post: @post)
    assert partial_for_liking(@post, @user) == "like_post"
  end

  test "heart icon is not displayed if post is not liked by user" do
    assert hidden_if_unliked(@post, @likes) == "display: none"
  end
end

