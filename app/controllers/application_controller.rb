class ApplicationController < ActionController::Base
  # Log all requests to the Rails logger.
  before_action :log_request

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

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
