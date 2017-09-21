class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    user_session_url
  end

  def after_inactive_sign_up_path_for(resource)
    user_session_url
  end
end
