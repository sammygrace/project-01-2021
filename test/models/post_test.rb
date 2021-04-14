require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_1)
  end

  test "should not save without a title" do
    post = @user.posts.new
    assert_not post.save
  end
end
