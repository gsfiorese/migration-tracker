class UserAdmin::VisasController < ApplicationController

  before_action :set_visa, only: [:show, :update, :edit, :destroy]
  before_action :set_visa_category, only: %i[new create]

  def index
    @visas = Visa.all
  end

  def new
    @visa = Visa.new
  end

  def create
    @visa = Visa.new(visa_params)
    @visa.visa_category = @visa_category
    if @visa.save
      redirect_to user_admin_visa_category_path(@visa_category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @visa_category= @visa.visa_category
  end

  def update
    @visa.update(visa_params)
    redirect_to user_admin_visa_path(@visa)
   end

  def show
    @visa_category = @visa.visa_category
  end

  def destroy
    @visa_category= @visa.visa_category
    @visa.destroy
      redirect_to user_admin_visa_category_path(@visa_category) , status: :see_other
  end

  private

  def visa_params
    params.require(:visa).permit(:name,:subclass)
  end

  def set_visa
    @visa = Visa.find(params[:id])
  end

  def set_visa_category
    @visa_category = VisaCategory.find(params[:visa_category_id])
  end

end
