require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:user_1)

    sign_in @user
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "creating a Post" do
    visit user_posts_url(@user)
    click_on "New Post"

    fill_in "Title", with: @post.title
    fill_in "Content", with: @post.content
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "my posts"
  end

  test "updating a Post" do
    post = @user.posts.sample
    assert_not_nil post

    ability = Ability.new(@user)
    assert ability.can?(:manage, post)

    visit user_post_path(@user, post)
    click_on "edit"
    assert_selector "h1", text: "Editing Post"

    fill_in "Title", with: @post.title
    fill_in "Content", with: @post.content
    click_on "Update Post"

    assert_text "Post was successfully updated"
  end

  test "destroying a Post" do
    visit user_post_url(@user, @user.posts.sample)
    assert_text "delete post"

    page.accept_confirm do
      click_on "delete post", match: :first
    end

    assert_text "Post was successfully destroyed"
  end

  test "visiting user posts" do
    user = User.all.sample
    visit user_posts_url(user)

    user.posts[0..9].each do |post|
      assert_link post.title
    end
  end
end
