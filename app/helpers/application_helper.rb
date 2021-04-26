module ApplicationHelper
  include Pagy::Frontend

  def hidden_if_no_user(user)
    if user == nil
      "display: none"
    end
  end

  def hidden_if_unauthorized_to_manage(resource)
    if cannot? :manage, resource
      "display: none"
    end
  end

  def hidden_if_owner_of_profile(user, profile)
    if user.id == profile.id
      "display: none"
    end
  end

  def hidden_if_owner_of_post(user, post)
    if post.user_id == user.id
      "display: none"
    end
  end

  def hidden_for_short_lists(resource)
    resource.count <= 10 ? "display: none" : "display: initial"
  end
end
