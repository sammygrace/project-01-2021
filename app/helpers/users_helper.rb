module UsersHelper
  def hidden_if_not_friends(me, you)
    if !me.friends.include?(you) && !you.friends.include?(me)
      "display: none"
    end
  end

  def hidden_if_already_friends(me, you)
    if me.friends.include?(you) || you.friends.include?(me)
      "display: none"
    end
  end

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
end
