require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    Faker::Name.unique.clear
    Faker::Internet.unique.clear

    @user = users(:user_1)
  end

  test "should not save if name already taken" do
    user = User.new
      user.email = Faker::Internet.unique.email
      user.name = @user.name
      user.description = Faker::Lorem.paragraph
      user.password = "password"
      attach_photo(user)

    assert_not user.save
  end
end
