class UserAdmin::VisaCategoriesController < ApplicationController
  before_action :authorize_admin, except: [:index, :show]
  before_action :authorize_member, only: [:index, :show]

  # For both admin and members
  def index
    @visa_categories = VisaCategory.all
    # Render different views based on the user role
    if current_user&.admin?
      render 'user_admin/visa_categories/index'
    else
      render 'user_member/visa_categories/index'
    end
  end

  # For both admin and members
  def show
    @visa_category = VisaCategory.find(params[:id])
    # Render different views based on the user role
    if current_user&.admin?
      render 'user_admin/visa_categories/show'
    else
      render 'user_member/visa_categories/show'
    end
  end

  # Admin-only actions
  def new
    @visa_category = VisaCategory.new
  end

  def create
    @visa_category = VisaCategory.new(visa_category_params)
    if @visa_category.save
      redirect_to user_admin_visa_categories_path(@visa_category), notice: 'Visa Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @visa_category = VisaCategory.find(params[:id])
  end

  def update
    @visa_category = VisaCategory.find(params[:id])
    if @visa_category.update(visa_category_params)
      redirect_to user_admin_visa_category_path(@visa_category), notice: 'Visa Category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @visa_category = VisaCategory.find(params[:id])
    @visa_category.destroy
    redirect_to user_admin_visa_categories_path, status: :see_other, notice: 'Visa Category was successfully deleted.'
  end

  private

  # Ensure only admin users can access admin actions
  def authorize_admin
    return if current_user&.admin?

    redirect_to root_path, alert: 'Access denied. Admins only.'
  end

  # Ensure only members can access member views
  def authorize_member
    return if current_user&.member? || current_user&.admin?

    redirect_to root_path, alert: 'Access denied. Members only.'
  end

  # Strong parameters for VisaCategory
  def visa_category_params
    params.require(:visa_category).permit(:name, :about)
  end
end
