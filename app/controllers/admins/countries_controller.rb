class Admins::CountriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_country, only: [:edit, :update]

  def index
    @countries = Country.all
  end
# Test
  def show
    @country = Country.find_by(id: params[:id])

    if @country.nil?
      flash[:alert] = "The country has been deleted."
      redirect_to admins_countries_path
    end
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      redirect_to admins_countries_path, notice: "Country was successfully created."
    else
      render :new
    end
  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find(params[:id])
    if @country.update(country_params)
      redirect_to admins_countries_path, notice: "Country was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @country = Country.find(params[:id])
    Rails.logger.debug "Attempting to delete country: #{@country.name}"
    if @country.destroy
      flash[:notice] = "Country deleted successfully."
    else
      flash[:alert] = "Failed to delete country."
    end
    redirect_to admins_countries_path
  end

  private

  def country_params
    params.require(:country).permit(:name, :description)
  end

  # def check_admin
    # unless current_user.admin?
      # redirect_to root_path, alert: "You must be an admin to perform this action."
    # end
  # end

  def set_country
    @country = Country.find(params[:id])
  end
end
