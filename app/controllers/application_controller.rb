class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :admin?

  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:handicap])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :handicap])
  end

  def admin?
    current_user && current_user.email == "toddteigland@gmail.com"
  end


end
