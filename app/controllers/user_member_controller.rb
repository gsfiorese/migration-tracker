class UserMemberController < ApplicationController
  def index
    @visa_categories = VisaCategory.all
  end
end
