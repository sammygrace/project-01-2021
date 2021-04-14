require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_1)
  end

  test "should not have duplicate names" do
    user = User.new(name: @user.name, email: Faker::Internet.email)
    assert_not user.save
  end
end
