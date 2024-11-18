class UserAdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @anzsco_codes = AnzscoCode.all
  end

  private

  def ensure_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user.admin?
  end
end
