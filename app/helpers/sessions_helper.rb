module SessionsHelper
  def log_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    session[:user_id] = user.id
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    cookies.delete(:remember_token)
    session.delete :user_id
  end
  
  def logged_in_as_factory_guy?
    !current_user.nil? && current_user.user_type == 'factory'
  end
  
  def logged_in_as_admin?
    !current_user.nil? && current_user.user_type == 'admin'
  end
      
  def current_user
    user = user_from_session
    user ||= user_from_remember_token
  end
      
  def current_company
    current_user.company
  end
  
  def user_home
    if logged_in?
      return admin_path if current_user.type == 'admin'
      return stores_path if current_user.type == 'store'
      return factory_path if current_user.type == 'factory'
    else
      return login_url
    end
  end
  
  private

    def user_from_remember_token
      remember_token = cookies[:remember_token]
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end
    
    def user_from_session
      User.find_by_id(session[:user_id])
    end
end
