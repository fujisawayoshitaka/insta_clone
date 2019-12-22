module ApplicationHelper
  def current_user?(user)
    current_user.id == user.id
  end

  def logged_in?
    current_user.present?
  end
end
