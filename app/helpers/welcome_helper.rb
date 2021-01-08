module WelcomeHelper
  def hidden_when_not_signed_in
    if !user_signed_in?
      "display: none"
    end
  end

  def hidden_when_signed_in
    if user_signed_in?
      "display: none"
    end
  end
end
