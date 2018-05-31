module UsersHelper
  def authorization(application, user=current_user)
    user.access_tokens.where(name: application).first
  end
end
