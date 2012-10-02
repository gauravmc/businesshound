class SessionsController < ApplicationController
  skip_before_filter :authorize
  
  def new
  end

  def create
    user = User.find_by_username(params[:username]) || User.find_by_email(params[:username])
    if user and user.authenticate(params[:password])
      if(params[:remember] == 'yes')
        log_in user
      else
        session[:user_id] = user.id
      end
      redirect_to user_home
    else
      redirect_to login_url, flash: { failure: "Invalid user/password combination" }
    end
  end

  def destroy
    log_out
    redirect_to login_url, flash: { success: "Logged out" }
  end
end
