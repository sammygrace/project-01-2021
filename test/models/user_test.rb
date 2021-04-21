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
      user.photo.attach(io: File.open('db/files/IMG_7772.JPG'), filename: 'IMG_7772.JPG')

    assert_not user.save
  end

=begin
  test "should have attached photo" do
    User.all.each do |user|
      assert user.photo.attached?
    end
  end
=end
end
