require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @like = likes(:one)
    @user = users(:one)
    sign_in @user
  end

  teardown do
    Rails.cache.clear
  end

  test "same user should not create multiple likes for the same post" do
    assert_equal @like.user, @user
    like = @user.likes.create(user: @user, post: @like.post)
    assert_not like.save, "user can create mulitiple likes for the same post"
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
