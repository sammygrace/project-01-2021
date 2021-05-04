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

=begin
  def attach_photo(user)
    img = "IMG_7772.JPG"
    path = "db/files/IMG_7772.JPG"
    user.photo.attach(io: File.open(path), filename: img)
  end
=end
end
