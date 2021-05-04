require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_1)
  end

 test "visiting the home page before signing in" do
   visit root_url

   assert_selector "h1", text: "Home Page"
   assert_link "Sign Up"
   assert_link "Sign In"
   assert_no_link "Sign Out"
   assert_no_link "All Posts"
 end

 test "visiting the home page after signing in" do
   sign_in @user
   visit root_url

   assert_selector "h1", text: "Home Page"
   assert_selector "p", text: "Welcome, #{@user.name}"

   assert_no_link "Sign Up"
   assert_no_link "Sign In"
   assert_link "Sign Out"
   assert_link "See Profile"
   assert_link "All Posts"
 end
end
