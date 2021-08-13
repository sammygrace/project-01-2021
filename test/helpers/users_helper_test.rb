class UsersHelperTest < ActionView::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @friendship = friendships(:one)
    @friendship_without_conversation = friendships(:two)
    @friendless_user = users(:user_7)
    @user = users(:user_1)
  end

  test "conversation form is hidden if friendship already has one" do
    assert_not_nil @friendship.conversation
    assert hidden_if_conversation(@friendship) == "display: none"
  end

  test "chat button is hidden if friendship has no conversation" do
    assert_nil @friendship_without_conversation.conversation
    assert hidden_if_no_conversation(@friendship_without_conversation) == "display: none"
  end

  test "correct partial is rendered for friendship" do
    assert partial_for_friendship(nil) == "make_friends"
    assert partial_for_friendship(@friendship_without_conversation) == "conversation_form"
  end

  test "message is displayed if user has no friends" do
    assert_equal @friendless_user.friends.count, 0
    assert display_message_if_friendless(@friendless_user, @friendless_user) == "You have no friends :("
    assert display_message_if_friendless(@friendless_user, @user) == "This user has no friends."
  end

  test "chat button goes to correct conversation" do
    @conversation = @friendship.conversation
    assert_equal "/conversations/#{@conversation.id}", conversation_path(@conversation)
  end
end

