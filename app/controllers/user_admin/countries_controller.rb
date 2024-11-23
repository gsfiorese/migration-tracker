class UserAdmin::CountriesController < ApplicationController

  def index
    @countries = Country.all
  end

  def show
    @country = Country.find(params[:id])
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    @country.save
    redirect_to user_admin_countries_path(@country)

  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find(params[:id])
    @country.update(country_params)
    redirect_to user_admin_country_path(@country)
  end

  def destroy
    @country = Country.find(params[:id])
    @country.destroy
    redirect_to user_admin_countries_path(@country), status: :see_other
  end

  private

  def country_params
    params.require(:country).permit(:name)
  end

end
