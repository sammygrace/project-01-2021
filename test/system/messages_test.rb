require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @message = messages(:one)
    @conversation = conversations(:one)
    @author = @conversation.author
    @friend = @conversation.friend

    @author.photo.attach(io: File.open('db/files/IMG_7772.JPG'), filename: 'IMG_7772.JPG')
    @friend.photo.attach(io: File.open('db/files/IMG_7772.JPG'), filename: 'IMG_7772.JPG')

    log_in @author
  end

  test "visiting the index" do
    visit messages_url
    assert_selector "h1", text: "Messages"
  end

  test "creating a Message" do
    visit friendship_conversation_url(@conversation.friendship, @conversation)

    assert_text "Author:"
    assert_text "Friend:"
    assert_text "Content"
    assert_field "message-content"

    fill_in "message-content", with: @message.content
    click_on "Create Message"

    assert_text "Message sent!"
    assert_text @message.content
  end
end
