class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    session[:previous_url] || root_path
  end

end
