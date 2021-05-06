ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  set_fixture_class active_storage_attachments: ActiveStorage::Attachment
  set_fixture_class active_storage_blobs: ActiveStorage::Blob
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::Test::IntegrationHelpers

  def attach_photo(user)
    img = "IMG_7772.JPG"
    path = "db/files/IMG_7772.JPG"
    user.photo.attach(io: File.open(path), filename: img)
  end
end
