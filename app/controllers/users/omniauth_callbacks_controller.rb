# This controller is responsible for handling the callback from Google OAuth2.
# It checks if the user is already registered in the database, if not, it creates a new user.
# It also sets the flash message for the user after successful login.
# If the user is not registered, it redirects to the registration page with an alert message.
# The controller inherits from Devise::OmniauthCallbacksController.

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end
