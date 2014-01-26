class PasswordsController < Devise::PasswordsController

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      sign_in(resource_name, resource)
      redirect_to root_path 
    else
      redirect_to root_path
    end
  end

  protected

  def after_reseting_password_path_for(user)
    return root_path
  end

end