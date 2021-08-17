require 'test_helper'

class PostFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_1)
    @post = @user.posts.first
    @posts = Post.all.order(:created_at).reverse_order

    sign_in @user
  end

  test "my posts path should show correct posts" do
    get "/my-posts"

    assert_select "h1", "My Posts"

    assert_select "tbody tr" do |posts|
      posts.each do |post|
        assert_select "td a", @user.name
      end
    end
  end

  test "should redirect to index after creating" do
    new_post = @user.posts.new(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph)

    get new_user_post_url(@user)
    post user_posts_url(@user), 
      params: { post: { user_id: new_post.user.id, title: new_post.title, content: new_post.content } }

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "h1", "Posts"
    assert_select "tbody tr td a", new_post.title
    assert_select "tbody tr td a", @user.name
  end

  test "should redirect to my posts after destroying" do
    get new_user_post_url(@user)
    delete user_post_url(@user, @post)

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "h1", "My Posts" 
  end

  test "should redirect to show after updating" do
    get edit_user_post_url(@user, @post)
    patch user_post_url(@user, @post), 
      params: { post: { title: "This should work" } }

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "h1", "This should work"
    assert_select "a", @user.name
  end
end
