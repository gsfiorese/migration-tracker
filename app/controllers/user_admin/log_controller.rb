class UserAdmin::LogController < ApplicationController
  def index
    @logs = Log
              .includes(:user) # Preload associated User data
              .order(
                Arel.sql("CASE WHEN log_type != 'info' OR status_code IS NOT NULL THEN 0 ELSE 1 END"),
                created_at: :desc
              )
              .page(params[:page]).per(15) # Paginate 15 logs per page
  end
end
