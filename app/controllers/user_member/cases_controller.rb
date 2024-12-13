module UserMember
  class CasesController < ApplicationController
    before_action :set_visa, only: [:index, :new]

    def index
      # If visa_id is present, filter cases by visa
      if params[:visa_id].present?
        @visa = Visa.find_by(id: params[:visa_id])
        @cases = Case.where(visa_id: @visa&.id).page(params[:page]).per(15)
      elsif params[:format].present?
        @visa = Visa.find_by(id: params[:format])
        @cases = Case.where(visa_id: @visa&.id).page(params[:page]).per(15)
      else
        @cases = Case.all
      end

      # Eager load comments for each case
      @comments = @cases.includes(:comments).map { |case_obj| case_obj.comments.includes(:user) }
      @comment = Comment.new
    end

    def new
      # Pre-fill the visa association when creating a new case
      if @visa
        @case = Case.new(visa: @visa)
      else
        redirect_to user_member_visas_path, alert: "Please select a visa before adding a case."
      end
    end

    def create
      @case = Case.new(case_params)
      @case.user = current_user # Assign the currently logged-in user

      if @case.save
        # Redirect to the index page with the associated visa_id after case creation
        redirect_to user_member_cases_path(visa_id: @case.visa_id), notice: "Case was successfully created."
      else
        render :new
      end
    end

    private

    # Set the visa object if visa_id is present in params
    def set_visa
      @visa = Visa.find_by(id: params[:visa_id])
    end

    # Strong parameters for case creation
    def case_params
      params.require(:case).permit(
        :country_id, :anzsco_code_id, :visa_id, :lodgement_date, :co_contact_date,
        :co_response_date, :grant_date, :assess_commence, :work_p_claim, :total_p,
        :on_shore, :case_status, :agency, :employment_verification, :sponsor_state,
        :documents, :co_contact_type, :engl_prof
      )
    end
  end
end
