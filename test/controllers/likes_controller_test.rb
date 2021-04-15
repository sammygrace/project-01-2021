require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @like = likes(:one)
    @user = users(:user_1)
    sign_in @user
  end

  test "should get user likes" do
    assert_routing "/users/1/likes", controller: "likes", action: "index", user_id: "1"
  end

  test "should create like" do
    new_like = @user.likes.new(user: @user, post: posts(:three))
    assert_not Like.find_by(user: @user, post: posts(:three)), "like already exists"
    assert new_like.save, "like did not save :("
  end

  test "should destroy like" do
    assert_not_nil user_like_url(@user, @like)
    assert_not_nil @like.post, "like does not belong to a post"

    assert_difference('Like.count', -1) do
      delete user_like_url(@user, @like)
    end

    assert_redirected_to post_path(@like.post), "did not redirect to correct url after deleting"
  end
end
