class UserMember::VisasController < ApplicationController
  before_action :set_visa_category, only: [:index]
  before_action :authorize_member

  def index
    @visas = @visa_category.visas
  end

  private

  def set_visa_category
    @visa_category = VisaCategory.find(params[:visa_category_id])
  end

  def authorize_member
    unless current_user&.member? || current_user&.admin?
      redirect_to root_path, alert: "Access denied. Members only."
    end
  end
end
