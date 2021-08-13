require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @post2 = posts(:two)
    @user = users(:user_1)

    log_in @user
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"

    within find("nav") do
      click_link "Home"
    end

    assert_selector "h1", text: "Home Page"

    within find("nav") do
      click_link "All Posts"
    end

    within find("thead tr") do
      assert_selector "th", text: "Title"
      assert_selector "th", text: "Likes"
      assert_selector "th", text: "Content"
      assert_selector "th", text: "Posted"
      assert_selector "th", text: "Author"
    end

    assert_link "New Post"
  end

  test "creating a Post" do
    visit new_user_post_url(@user)
    assert_selector "h1", text: "New Post"

    click_link "Cancel"
    assert_selector "h1", text: "Posts"

    click_on "New Post"

    post = Post.new(title: "My Post", user_id: @user.id, content: "this is my post")
    fill_in "Title", with: post.title
    fill_in "Content", with: post.content
    click_on "Create Post"

    assert_text "Post was successfully created"
    assert_selector "h1", text: post.title
    click_on "my posts"
  end

  test "updating a Post" do
    post = @user.posts.sample
    assert_not_nil post

    visit edit_user_post_url(@user, post)
    assert_selector "h1", text: "Editing Post"
    click_link "Cancel"

    click_on "edit"

    fill_in "Title", with: @post.title
    fill_in "Content", with: @post.content
    click_on "Update Post"

    assert_text "Post was successfully updated"
  end

  test "destroying a Post" do
    visit user_post_url(@user, @user.posts.sample)

    page.accept_confirm do
      click_on "delete post", match: :first
    end

    assert_text "Post was successfully destroyed"
  end

  test "visiting user posts" do
    user = users(:user_2)
    posts = user.posts.order(:created_at).reverse_order
    visit user_posts_url(user)
    assert_selector "h1", text: 'Posts'

    within find("tr", text: posts.first.title) do 
      click_on user.name
    end

    assert_selector "h1", text: user.name
    click_on "More Posts by #{user.name} =>"

    posts[0..9].each do |post|
      assert_link post.title
    end
  end

  test "visiting user's own post" do
    visit user_post_url(@post.user, @post)
    assert_selector "h1", text: @post.title
    assert_selector "p", text: @post.content

    click_link @post.user.name
    assert_selector "h1", text: @post.user.name
  end

  test "visiting another user's post" do
    visit user_post_url(@post2.user, @post2)
    assert_selector "h1", text: @post2.title

    click_on "More Posts By #{@post2.user.name}"
    assert_selector "h1", text: "Posts"

    click_on @post2.title
    assert_selector "h1", text: @post2.title

    click_link @post2.user.name
    assert_selector "h1", text: @post2.user.name
  end
end
