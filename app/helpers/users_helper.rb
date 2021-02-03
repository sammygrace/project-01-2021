module UsersHelper
  def hidden_if_conversation(friendship)
    if friendship.conversation.present?
      "display: none"
    end
  end

  def hidden_if_no_conversation(friendship)
    if !friendship.conversation.present?
      "display: none"
    end
  end

  def link_to_conversation(friendship)
    friendship_conversation_path(friendship, friendship.conversation) if friendship.conversation
  end

  def partial_for_friendship(friendship)
    if friendship.present?
      "conversation_form"
    else
      "make_friends"
    end
  end

  def display_message_if_friendless(user)
    if user.friends.count + user.users.count == 0
      if user.id == current_user.id
        "You have no friends :("
      else
        "This user has no friends."
      end
    end
  end
end
