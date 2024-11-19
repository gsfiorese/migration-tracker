class VisasController < ApplicationController

  before_action :set_visa, only: [:show, :edit, :update, :destroy]
  before_action :set_visa_category, only: [:new, :create]

  def index
    @visas = Visa.all
  end

  def new
    @visa = Visa.new
  end

  def create
    @visa_category = VisaCategory.find(params[:visa_category_id])
    @visa = Visa.new(visa_params)
    @visa.visa_category = @visa_category
    @visa.save
    redirect_to visa_category_path(@visa_category)
  end


private

def set_visa
  @visa = Visa.find(params[:id])
  @visa_category = @visa.visa_category # Load the associated visa category
end

def set_visa_category
  @visa_category = VisaCategory.find(params[:visa_category_id])
end



def visa_params
  params.require(:visa).permit(:visa_name, :subclass)
end
