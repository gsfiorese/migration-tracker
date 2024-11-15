class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    # Your admin dashboard or actions
  end

  private

  def ensure_admin!
    redirect_to root_path, alert: 'Access Denied' unless current_user&.admin?
  end
end
