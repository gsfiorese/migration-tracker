class UserMember::VisasController < ApplicationController
  def index
    @visa_category = VisaCategory.find(params[:visa_category_id])
    @visas = @visa_category.visas
  end
end
