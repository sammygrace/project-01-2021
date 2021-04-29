require 'test_helper'

class LikeFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_5)
    @post = posts(:one)
    @like = likes(:one)

    sign_in @user
  end

  test "should redirect to post after liking" do
    new_like = @user.likes.new(post_id: @post.id)
    post user_likes_url(@user), params: { like: { post_id: new_like.post_id, user_id: new_like.user_id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "h1", @post.title
    assert_select "p", "You liked this post!"
    assert_select "form input", false
  end

  test "should redirect to post after unliking" do
    get user_post_url(@like.post.user, @like.post)
    delete user_like_url(@like.user, @like)
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "p", "Unliked this post."
    assert_select "h1", @like.post.title
    assert_select "form input", { :value => "Like This Post" }
  end
end
