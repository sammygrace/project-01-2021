require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  def remove_uploaded_files
    FileUtils.rm_rf("#{Rails.root}/storage_test")
  end

  def after_teardown
    super
    remove_uploaded_files
  end

  def navigate_link(link, heading_text)
    click_link(link)
    assert_text(heading_text)
  end

  def back_to_profile
    within find("nav") do
      click_link "Profile"
    end
  end

  def log_in(user)
    visit root_url
    click_on "Sign In"

    assert_text "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: 'password'

    click_on "Log in"
    assert_text "Signed in successfully."
  end
end
