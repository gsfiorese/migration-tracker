class UserAdmin::VisasController < ApplicationController

  before_action :set_visa, only: [:show, :update, :edit, :destroy]
  before_action :set_visa_category, only: %i[index new create]
  before_action :authorize_admin

  def index
    @visas = @visa_category.visas # Fetch visas for the specific visa category
  end

  def new
    @visa = Visa.new
  end

  def create
    @visa = Visa.new(visa_params)
    @visa.visa_category = @visa_category
    if @visa.save
      redirect_to user_admin_visa_category_path(@visa_category), notice: 'Visa was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @visa_category = @visa.visa_category
  end

  def update
    if @visa.update(visa_params)
      redirect_to user_admin_visa_path(@visa), notice: 'Visa was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @visa_category = @visa.visa_category
  end

  def destroy
    @visa_category = @visa.visa_category
    @visa.destroy
    redirect_to user_admin_visa_category_path(@visa_category), status: :see_other, notice: 'Visa was successfully deleted.'
  end

  private

  def visa_params
    params.require(:visa).permit(:name, :subclass)
  end

  def set_visa
    @visa = Visa.find(params[:id])
  end

  def set_visa_category
    @visa_category = VisaCategory.find(params[:visa_category_id])
  end

  def authorize_admin
    redirect_to root_path, alert: 'Access denied. Admins only.' unless current_user&.admin?
  end

end
