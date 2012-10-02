class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper
  
  protected

    def authorize
      redirect_to login_url, notice: "Please log in first" unless logged_in?
    end
end
