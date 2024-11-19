module UserAdmin::LogHelper
  def log_user_name(log)
    log.user ? "#{log.user.first_name} #{log.user.last_name}" : "Unknown User"
  end

  def log_user_role(log)
    log.user&.role || "N/A"
  end
end
