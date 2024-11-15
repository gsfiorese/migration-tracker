class ApplicationController < ActionController::Base
  # Log all requests to the Rails logger.
  before_action :log_request

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  # Redirect users after sign in based on their role
  def after_sign_in_path_for(resource)
    if resource.admin?
      user_admin_index_path # Replace with the actual path for Admin Index
    elsif resource.member?
      user_member_index_path # Replace with the actual path for Member Index
    else
      root_path # Fallback path
    end
  end

  # Redirect users after sign out to welcome page
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  private

  def log_request
    LoggerService.log_action(
      log_type: 'info',
      message: "#{action_name} action called in #{controller_name}",
      user: current_user,
      source: "#{controller_name}##{action_name}",
      context: { params: params.to_unsafe_h }
    )
  end

end
