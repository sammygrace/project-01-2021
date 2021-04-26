module WelcomeHelper
  def hidden_when_signed_in(user)
    if user.present?
      "display: none"
    end
  end
end
