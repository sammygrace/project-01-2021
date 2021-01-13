module ApplicationHelper
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
end
