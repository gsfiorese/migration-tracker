class SessionsController < Devise::SessionsController
  def destroy
    super
    Rails.logger.debug "User has signed out."
  end
end
