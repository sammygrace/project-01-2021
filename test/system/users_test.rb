require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
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

    click_link "New Post"
    assert_text "New Post"
    click_link "Profile"

    click_link "Edit Profile"
    assert_text "Edit User"
    click_link "Profile"
    
    click_link "My Posts"
    assert_text "Posts"
    click_link "Profile"

    click_link "Liked Posts"
    assert_text "Liked Posts"
    click_link "Profile"
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

    click_on "Home"
    click_link "Sign Up"

    @new_user = User.new(
      email: Faker::Internet.email,
      password: "password",
      name: Faker::Name.first_name,
      description: Faker::Lorem.paragraph, 
    )
    path = 'db/files/IMG_7772.JPG'

    fill_in "Name", with: @new_user.name
    fill_in "Description", with: @new_user.description
    fill_in "Email", with: @new_user.email
    fill_in "Password", with: @new_user.password
    fill_in "Password confirmation", with: @new_user.password
    attach_file "Photo", path

    click_on "Sign up"

    assert_text "Welcome! You have signed up successfully."
    assert_selector "p", text: "Welcome, #{@new_user.name}"
  end

  test "logging in" do
    sign_out @user1
    visit new_user_session_url
    assert_selector "h2", text: "Log in" 

    click_on "Home"
    click_link "Sign In"

=begin
    fill_in "Email", with: @user2.email
    fill_in "Password", with: @user2.password

    click_on "Log in"

    assert_text "Signed in successfully."
=end
  end

  test "editing profile" do
    visit edit_user_registration_path(@user1)
    assert_text "Edit User"

    click_on "Back to User"

    assert_selector "h1", text: @user1.name
    click_on "Edit Profile"

=begin
    path = 'db/files/IMG_7772.JPG'
    attach_file "Photo", path

    fill_in "Current password", with: @user1.password

    click_on "Update"

    assert_text "Your account has been updated successfully."
    assert_selector "h1", "Home Page"
=end
  end
end
