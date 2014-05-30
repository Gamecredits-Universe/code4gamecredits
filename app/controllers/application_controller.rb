class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if request.xhr?
      raise exception
    else
      redirect_to root_path, :alert => "Access denied"
    end
  end

  protected
  def after_sign_in_path_for(user)
    params[:return_url].presence ||
      root_path
  end
end
