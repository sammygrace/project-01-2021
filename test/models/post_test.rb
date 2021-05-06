require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_1)
    @post = posts(:one)
  end

  test "should not save without a title" do
    post = @user.posts.new
    assert_not post.save
  end

  test "should belong to a user" do
    Post.all.each do |post|
      assert_not_nil post.user
    end
  end

  test "should not be able to manage other users' posts" do
    user = users(:user_5)
    assert_not_equal @post.user, user

    ability = Ability.new(user)
    assert ability.cannot? :manage, @post
  end
end
