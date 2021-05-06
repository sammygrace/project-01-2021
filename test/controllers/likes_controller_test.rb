require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @like = likes(:one)
    @user = users(:user_5)
    @post = posts(:one)

    sign_in @user
  end

  test "should get user likes" do
    assert_routing "/users/1/likes", controller: "likes", action: "index", user_id: "1"

    get user_likes_path(@user)
    assert_response :success
  end

  test "should create like" do
    new_like = @user.likes.new(post: @post)
    assert_difference('Like.count') do
      post user_likes_url(@user), params: { like: { user_id: @user.id, post_id: new_like.post_id } }
    end

    assert_redirected_to user_post_url(@post.user, @post)
  end

  test "should destroy like" do
    assert_not_nil @like.post, "like does not belong to a post"

    assert_difference('Like.count', -1) do
      delete user_like_url(@like.user, @like)
    end

    assert_redirected_to user_post_path(@like.post.user, @like.post), "did not redirect to correct url after deleting"
  end
end
