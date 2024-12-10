module UserMember
  class CasesController < ApplicationController
    before_action :set_visa, only: [:index, :new, ]
    # before_action :set_visa, only: [:create_comment]

    def index
      if params[:visa_id].present?
        @visa = Visa.find_by(id: params[:visa_id])
        @cases = Case.where(visa_id: @visa&.id)
      elsif params[:format].present?
        @visa = Visa.find_by(id: params[:format])
        @cases = Case.where(visa_id: @visa&.id)
      else
        @cases = Case.all
      end
      @comments = @cases.map { |case_obj| case_obj.comments.includes(:user) }
      @comment = Comment.new
    end


    def new
      if @visa
        @case = Case.new(visa: @visa) # Pre-fill the visa association
      else
        redirect_to user_member_visas_path, alert: "Please select a visa before adding a case."
      end
    end

    def create
      @case = Case.new(case_params)
      @case.user = current_user # Assign the currently logged-in user

      if @case.save
        redirect_to user_member_cases_path, notice: "Case was successfully created."
      else
        render :new
      end
    end

    # def create_comment
    #   @visa = Visa.find(params[:visa_id])
    #   @comment = @visa.comments.new(comment_params)
    #   @comment.user = current_user

    #   if @comment.save
    #     respond_to do |format|
    #       format.html { redirect_to user_member_cases_path, notice: "Comment added successfully." }  # fallback for non-AJAX requests
    #       format.js   # This will look for a create.js.erb file to handle the comment addition
    #     end
    #   else
    #     flash.now[:alert] = "Failed to add comment."
    #     render :index
    #   end
    # end

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
    # Strong parameters for comment creation
    # def comment_params
    #   params.require(:comment).permit(:content, :visa_id, :case_id)
    # end
  end
end
