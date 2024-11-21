class UserAdmin::AnzscoCodesController < ApplicationController
  def index
    @anzsco_codes = AnzscoCode.all
  end

  def show
    @anzsco_code = AnzscoCode.find(params[:id])
  end

  def new
    @anzsco_code = AnzscoCode.new
  end

  def create
    @anzsco_code = AnzscoCode.new (anzsco_codes_params)
    @anzsco_code.save
    redirect_to user_admin_anzsco_codes_path(@anzsco_code)
  end

  def edit
   @anzsco_code = AnzscoCode.find(params[:id])
  end

  def update
    @anzsco_code = AnzscoCode.find(params[:id])
    @anzsco_code.update(anzsco_codes_params)
    redirect_to user_admin_anzsco_codes_path(@anzsco_code)
  end

  def destroy
    @anzsco_code = AnzscoCode.find(params[:id])
    @anzsco_code.destroy
    redirect_to user_admin_anzsco_codes_path, status: :see_other
  end

  private
  def anzsco_codes_params
    params.require(:anzsco_code).permit(:anzsco_code, :occupation, :description)
  end
end
