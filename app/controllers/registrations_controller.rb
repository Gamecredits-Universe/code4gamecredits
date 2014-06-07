class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)

    user_params = devise_parameter_sanitizer.sanitize(:account_update)

    successfully_updated = if @user.has_password?
      @user.update_with_password(user_params)
    else
      @user.update(user_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end
end
