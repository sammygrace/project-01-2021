module ApplicationHelper
  def hidden_when_not_signed_in
    if !user_signed_in?
      "display: none"
    end
  end
end
