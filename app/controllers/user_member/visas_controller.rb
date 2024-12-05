class UserMember::VisasController < ApplicationController
  before_action :set_visa_category, only: [:index]
  before_action :authorize_member

  def index
    @visas = @visa_category.visas
    if params[:query].present?
      query = params[:query]

      # Check if the query is numeric for subclass comparison
      if query.match?(/\A\d+\z/) # Regex to check if query is a number
        sql_subquery = "name ILIKE :query OR subclass = :subclass"
        @visas = @visas.where(sql_subquery, query: "%#{query}%", subclass: query.to_i)
      else
        sql_subquery = "name ILIKE :query"
        @visas = @visas.where(sql_subquery, query: "%#{query}%")
      end
    end
  end

  private

  def set_visa_category
    if params[:visa_category_id].present?
      @visa_category = VisaCategory.find(params[:visa_category_id])
    else
      redirect_to user_member_visa_categories_path, alert: "Visa category not specified."
    end
  end


  def authorize_member
    unless current_user&.member? || current_user&.admin?
      redirect_to root_path, alert: "Access denied. Members only."
    end
  end
end
