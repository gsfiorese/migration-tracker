class UserMemberController < ApplicationController
  def index
    @visa_categories = VisaCategory.all
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR about ILIKE :query"
      @visa_categories = @visa_categories.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end
end
