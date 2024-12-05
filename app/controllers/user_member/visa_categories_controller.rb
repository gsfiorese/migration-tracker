class UserMember::VisaCategoriesController < ApplicationController

  def index
    @visas = Visa.all # Fetch visas for the specific visa category
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR subclass ILIKE :query"
      @visas = @visas.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end
end
