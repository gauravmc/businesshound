require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  test "login logout" do
    log_out
    assert_nil session[:user_id]
    assert_nil cookies[:remember_token]
    assert !logged_in?
    
    log_in users(:steve)
    assert_equal users(:steve).id, session[:user_id]
    assert_equal users(:steve).remember_token, cookies[:remember_token]
    assert logged_in?
  end
  
  test "current user and current company" do
    log_out
    log_in users(:steve)
    assert_equal users(:steve), current_user
    assert_equal companies(:apple), current_company
  end
end
