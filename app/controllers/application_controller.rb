class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :admin?

  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:handicap])
  end

  def admin?
    current_user && current_user.email == "toddteigland@gmail.com"
  end

  def forgot_password
    user = User.find_by(email: params[:email])
    if user
      user.generate_reset_token! # Add a method to your User model
      UserMailer.forgot_password(user).deliver_now
    end
    flash[:notice] = "If that email exists, password reset instructions have been sent."
    redirect_to root_path
  end
  

end
