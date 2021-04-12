require "application_system_test_case"

class LikesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @like = likes(:one)
    @post = posts(:one)
    @user = users(:user_3)

    sign_in @user
  end

  test "creating a Like" do
    assert_nil @user.likes.find_by(post: @post), "user already liked this post"

    visit user_post_url(@post.user, @post) 

    click_on "Like This Post"

    assert_text "You liked this post!"
    assert_link "Unlike This Post"
  end

  test "destroying a Like" do
    assert_nil @user.likes.find_by(post: @post), "user already liked this post"

    visit user_post_url(@like.post.user, @like.post) 
    click_on "Like This Post"

    assert_text "You liked this post!"
    assert_link "Unlike This Post"
    assert @like.save

    click_link "Unlike This Post" 

    assert_text "Unliked this post."
  end
end

