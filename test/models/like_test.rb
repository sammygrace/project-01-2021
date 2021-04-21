require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  setup do
    @like = likes(:one)
    @user = users(:user_1)
  end

  test "user should not like post more than once" do
    assert_equal @like.user, @user
    like = @user.likes.create(user: @user, post: @like.post)
    assert_not like.save, "user can create mulitiple likes for the same post"
  end

  test "user should not like his own posts" do
    ability = Ability.new(@user)
    @user.posts.each do |post|
      assert_equal post.user_id, @user.id
      assert_not ability.can?(:create, post.likes.new(user_id: @user.id))
    end
  end

  test "every like should belong to a user and a post" do
    Like.all.each do |like|
      assert_not_nil like.user
      assert_not_nil like.post
    end
  end
end
