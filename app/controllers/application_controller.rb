class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_filter :set_time_zone

  def after_sign_in_path_for(resource)
    if params[:admin_user].nil?
      landing_user_index_path
    else
      admin_root_url
    end
  end

  def set_time_zone
    Time.zone = current_user.timezone unless current_user.blank?
  end


  protected

  def configure_devise_permitted_parameters
 	devise_parameter_sanitizer.for(:sign_in) { 
        |u| u.permit(:login, :fname,:password, :email, :remember_me) 
    }	

    devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(:fname, :email, :password, :password_confirmation,:accesslevel,:viralstyleapikey,
        	:emailverificationcode,:tableprefix,:timezonecode,:password_hash,:card_type, :card_number,:cvv,:card_expires_on,:card_name,:payment_status,:uid,:provider,:first_name,:last_name,:phone, :remote_avatar_url) 
    }

    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:password, :password_confirmation, :current_password, :first_name, :last_name, :phone, :avatar) 
    }
  end

end
