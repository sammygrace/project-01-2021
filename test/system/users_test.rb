require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:user_1)
    @user2 = users(:user_2)

    log_in @user1
  end

  test "visiting profile page" do
    visit root_url
    click_on "See Profile"

    assert_selector "h1", text: @user1.name
    assert_no_selector "h3", text: "Recent Posts"
    assert_selector "h3", text: "Recent Friends' Posts"

    within find("div") do
      assert_link "New Post"
      assert_link "Edit Profile"
      assert_link "My Posts"
      assert_link "Liked Posts"
    end

    navigate_link("New Post", "New Post")
    back_to_profile

    navigate_link("Edit Profile", "Edit User")
    back_to_profile

    navigate_link("My Posts", "Posts")
    back_to_profile

    navigate_link("Liked Posts", "Liked Posts")
    back_to_profile
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
    visit root_url
    click_on "Sign Out"
    assert_selector "p.notice", text: "Signed out successfully."

    new_user = User.new({
      email: "newuser@systemtest.com",
      name: "New User",
      description: "this should not fail",
      password: "password"
    })

    path = 'db/files/IMG_7772.JPG'

    visit new_user_registration_url
    assert_selector "h2", text: "Sign up" 

    click_on "Home"
    click_link "Sign Up"

    fill_in "user_name", with: new_user.name
    fill_in "Description", with: new_user.description
    fill_in "Email", with: new_user.email
    fill_in "Password", with: new_user.password
    fill_in "Password confirmation", with: new_user.password
    attach_file "Photo", path

    click_on "Sign up"

    assert_selector "p.notice", text: "Welcome! You have signed up successfully."
    assert_selector "div p", text: "Welcome, #{new_user.name}"
  end

  test "logging in" do
    visit root_url
    click_on "Sign Out"
    assert_text "Signed out successfully"

    click_on "Sign In"

    assert_selector "h2", text: "Log in" 

    fill_in "Email", with: @user2.email
    fill_in "Password", with: 'password'

    click_on "Log in"

    assert_text "Signed in successfully."
  end

  test "editing profile" do
    visit edit_user_registration_url(@user1)
    assert_text "Edit User"

    click_on "Back to User"

    assert_selector "h1", text: @user1.name
    click_on "Edit Profile"

    path = 'db/files/IMG_7772.JPG'
    attach_file "Photo", path

    fill_in "Current password", with: "password"

    click_on "Update"

    assert_text "Your account has been updated successfully."
    assert_selector "h1", text: "Home Page"
  end
end
