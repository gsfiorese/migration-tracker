# app/services/logger_service.rb
class LoggerService
  def self.log_action(log_type:, message:, user: nil, status_code: nil, source: nil, context: {})
    Log.create(
      log_type: log_type,
      message: message,
      user: user,
      status_code: status_code,
      source: source,
      context: context
    )
  end
end
