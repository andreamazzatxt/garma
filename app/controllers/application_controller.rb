class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? } 
  before_action :authenticate_user!, :do_not_set_cookie, if: -> { request.format.json? }
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :birthday, :gender, :photo, :email, :password)}

       devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :birthday, :gender, :photo, :email, :password, :reset_password_token, :password_confirmation, :current_password)}
  end

  def do_not_set_cookie
    request.session_options[:skip] = true
  end
end
