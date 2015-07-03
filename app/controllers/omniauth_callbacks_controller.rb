class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    if User.where(uid: request.env["omniauth.auth"]["uid"]).first.nil?
      if User.where(email: request.env["omniauth.auth"]["info"]["email"]).first.nil?
        session[:facebook_data] = request.env["omniauth.auth"]
        redirect_to root_url
      else
        redirect_to root_url, alert: "Email Address already Registered"
      end
    else  
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end

  def google_oauth2
    if User.where(uid: request.env["omniauth.auth"]["uid"]).first.nil?
      if User.where(email: request.env["omniauth.auth"]["info"]["email"]).first.nil?
        session[:facebook_data] = request.env["omniauth.auth"]
        redirect_to root_url
      else
        redirect_to root_url, alert: "Email Address already Registered"
      end
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end
end