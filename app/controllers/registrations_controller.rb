class RegistrationsController < Devise::RegistrationsController
 
  before_filter :configure_permitted_parameters

protected
# permitir parametros custom
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :first_name, :last_name, :login_name, :password, :password_confirmation)
    end
   devise_parameter_sanitizer.for(:account_update) do |u|
     u.permit(:email, :first_name, :last_name, :login_name, :password, :password_confirmation, :current_password)
     end
  end
end
