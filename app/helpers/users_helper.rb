module UsersHelper
  def authorization(application)
    current_user.access_tokens.where(name: application).first
  end
end
