require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:user_1)
    sign_in(@user)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should not get index if not signed in" do
    sign_out(@user)
    get posts_url
    assert_response :redirect
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post user_posts_url(@user), params: { post: { content: @post.content, title: @post.title, user_id: @post.user_id } }
    end

    assert_redirected_to user_post_url(@user, Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_post_url(@post.user, @post)
    assert_response :success
  end

  test "should only edit post if belongs to user" do
    post = users(:user_2).posts.first
    assert_not_nil post
    get edit_user_post_url(post.user, post)
    assert_response :redirect, "can edit posts that do not belong to user"
  end

  test "should update post" do
    patch user_post_url(@post.user, @post), params: { post: { content: @post.content, title: @post.title, user_id: @post.user_id } }
    assert_redirected_to user_post_url(@post.user, @post)
  end

  test "should redirect if failed to update" do
    patch user_post_url(@post.user, @post), params: { post: { content: @post.content, title: "", user_id: @post.user_id } }
    assert_redirected_to edit_user_post_url(@post.user, @post)
  end

  test "should destroy post" do
    assert_equal @post.user, @user
    assert_difference('Post.count', -1) do
      delete user_post_url(@post.user, @post)
    end

    assert_redirected_to user_posts_url(@post.user)
  end
end
