require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:user_1)
    @user2 = users(:user_2)

    sign_in @user1
  end

  test "visiting profile page" do
    visit root_url
    click_on "See Profile"

    assert_selector "h1", text: @user1.name
    assert_no_selector "h3", text: "Recent Posts"
    assert_selector "h3", text: "Recent Friends' Posts"

    assert_link "New Post"
    assert_link "Edit Profile"
    assert_link "My Posts"
    assert_link "Liked Posts"
  end

  test "visiting another user's profile" do
    visit user_url(@user2)

    assert_selector "h1", text: @user2.name
    assert_selector "h3", text: "Recent Posts"
    assert_selector "h3", text: "Recent Friends' Posts"

    assert_no_link "New Post"
    assert_no_link "Edit Profile"
    assert_no_link "My Posts"
    assert_no_link "Liked Posts"
  end

  test "signing up" do
    sign_out @user1
    visit new_user_registration_url
    assert_selector "h2", text: "Sign up" 

    user = User.new(
      email: Faker::Internet.unique.email,
      password: "password",
      name: Faker::Name.unique.first_name,
      description: Faker::Lorem.paragraph, 
    )
    path = 'db/files/IMG_7772.JPG'

    fill_in "Name", with: user.name
    fill_in "Description", with: user.description
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    attach_file "Photo", path

    click_on "Sign up"

    assert_text "Welcome! You have signed up successfully."
    assert_text "Welcome, #{user.name}"
  end
end
