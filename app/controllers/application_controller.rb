class ApplicationController < ActionController::Base
  # Log all requests to the Rails logger.
  before_action :log_request
  # before_action :authenticate_user! # Ensure user is authenticated before accessing any page

  # Ensure only modern browsers are allowed
  # Adjust according to the correct implementation of the `allow_browser` method.
  allow_browser versions: :modern

  # Sign out the current user and redirect to the root path
  def destroy_user_session
    sign_out current_user
    redirect_to root_path
  end

  private

  # Log the request with relevant details
  def log_request
    LoggerService.log_action(
      log_type: 'info',
      message: "#{action_name} action called in #{controller_name}",
      user: current_user,
      source: "#{controller_name}##{action_name}",
      context: { params: params.to_unsafe_h }
    )
  end

    # Redirect users after login based on their role
    def after_sign_in_path_for(resource)
      if resource.is_admin?
        admin_dashboard_path # or any specific path you want for admins
      else
        root_path # or any default path for users
      end
    end
end
