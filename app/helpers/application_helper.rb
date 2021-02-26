module ApplicationHelper
  include Pagy::Frontend

  def hidden_when_not_signed_in
    if !user_signed_in?
      "display: none"
    end
  end

  def hidden_if_unauthorized_to_manage(resource)
    if cannot? :manage, resource
      "display: none"
    end
  end

  def hidden_if_owner_of(user)
    if user == current_user
      "display: none"
    end
  end

  def hidden_for_short_lists(resource)
    resource.count <= 10 ? "display: none" : "display: initial"
  end
end
