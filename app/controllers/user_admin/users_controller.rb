class UserAdmin::UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy]

    # GET /admins/users
    def index
      @users = User.all
      if params[:query].present?
        query = params[:query]

        # Check if the query is numeric for subclass comparison
        if query.match?(/\A\d+\z/) # Regex to check if query is a number
          sql_subquery = "email ILIKE :query"
          @users = @users.where(sql_subquery, query: "%#{query}%")
        else
          sql_subquery = "email ILIKE :query"
          @users = @users.where(sql_subquery, query: "%#{query}%")
        end
      end
    end

    # GET /admins/users/:id/edit
    def edit
    end

    # PATCH /admins/users/:id
    def update
      @user.update(user_params)
      redirect_to user_admin_users_path
    end

    # DELETE /admins/users/:id
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admins_users_path, notice: 'User was successfully deleted.'
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :username, :role)
    end
end
