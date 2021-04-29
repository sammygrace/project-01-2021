require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_1)
    @friend = @user.friends.first

    sign_in @user
  end

  test "should show recent friends' posts" do
    get user_path(@user)

    assert_select "h3", "Recent Friends' Posts"
    assert_select "a#friend-post", { :maximum => 3 }
  end

  test "should display correct links if visiting users' own profile" do
    get user_path(@user)

    assert_select "a", "New Post"
    assert_select "a", "Edit Profile"
    assert_select "a", "My Posts"
    assert_select "a", "Liked Posts"

    assert_select "a", { :html => "display: none", :text => "More Posts by #{@user.name} =>" }
  end

  test "should display correct links if visiting another user" do
    get user_path(@friend)

    assert_select "a", "More Posts by #{@friend.name} =>"

    assert_select "a", { :html => "display: none", :text => "New Post" }
    assert_select "a", { :html => "display: none", :text => "Liked Posts" }
    assert_select "a", { :html => "display: none", :text => "My Posts" }
    assert_select "a", { :html => "display: none", :text => "Edit Profile" }
  end
end
