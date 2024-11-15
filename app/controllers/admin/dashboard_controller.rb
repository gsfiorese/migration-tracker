module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin

    def index
      # This will render the admin dashboard view
    end

    private

    # Ensure only admins can access the admin section
    def check_admin
      redirect_to root_path, alert: "You are not authorized to view this page" unless current_user.is_admin?
    end
  end
end
