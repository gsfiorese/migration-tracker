module UserMember
#   module Cases
    class CommentsController < ApplicationController
      before_action :set_commentable # Dynamically find the Visa or Case

      def create
        @comment = @commentable.comments.build(comment_params)
        @comment.user = current_user# Assign the currently logged-in user
        @comment.visa_id = params[:visa_id] # Assign visa_id explicitly

        if @comment.save
          # Respond with the newly created comment (AJAX will handle rendering)
          respond_to do |format|
            format.html { redirect_to user_member_cases_path(params[:visa_id]), notice: 'Comment added successfully.' }
            format.js   # This will render create.js.erb (for AJAX response)
          end
        else
          # Handle errors if the comment was not saved
          respond_to do |format|
            format.html { render 'user_member/cases/index', alert: 'Failed to add comment.' }
            format.js   { render 'user_member/cases/comments/error' }
          end
        end
      end

      private

      # Dynamically set the commentable model (Visa or Case)
      def set_commentable
        if params[:visa_id].present?
          @commentable = Visa.find(params[:visa_id]) # Find Visa by ID
        elsif params[:case_id].present?
          @commentable = Case.find(params[:case_id]) # Find Case by ID
        else
          flash.now[:alert] = 'Visa or Case not found.'
          redirect_to user_member_cases_path
        end
      end

      def comment_params
        params.require(:comment).permit(:content) # Adjust the params as needed
      end
    end
#   end
end
