require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  setup do
    @like = likes(:one)
    @user = users(:user_1)
  end

  test "user should not like post more than once" do
    assert Like.find_by(user: @like.user, post: @like.post)
    like = Like.new(user: @like.user, post: @like.post)
    assert_not like.save
  end

  test "user should not like his own posts" do
    ability = Ability.new(@user)
    @user.posts.each do |post|
      assert_equal post.user_id, @user.id
      assert_not ability.can?(:create, post.likes.new(user_id: @user.id))
    end
  end
end
