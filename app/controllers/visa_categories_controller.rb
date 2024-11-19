class VisaCategoriesController < ApplicationController
  def index
    @visa_categories = VisaCategory.all
  end

  def show
    @visa_category = VisaCategory.find (params[:id])
  end

  def new
    @visa_category = VisaCategory.new
  end

  def create
    @visa_category = VisaCategory.new (visa_category_params)
    @visa_category.save
    redirect_to visa_category_path(@visa_category)
  end

  def edit
   @visa_category = VisaCategory.find(params[:id])
  end

  def update
    @visa_category = VisaCategory.find(params[:id])
    @visa_category.update(visa_category_params)
    redirect_to visa_category_path(@visa_category)
  end

  def destroy
    @visa_category = VisaCategory.find(params[:id])
    @visa_category.destroy
    redirect_to visa_categories_path, status: :see_other
  end

private

def visa_category_params
  params.require(:visa_category).permit(:name, :about)
end

end
