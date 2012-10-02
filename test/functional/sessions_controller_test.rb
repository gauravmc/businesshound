require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    steve = users(:steve)
    
    post :create, username: steve.email, password: '7sjy1bss'
    assert_redirected_to admin_url
    assert_equal steve.id, session[:user_id]
    
    post :create, username: steve.username, password: '7sjy1bss'
    assert_redirected_to admin_url
    assert_equal steve.id, session[:user_id]
  end

  test "should fail login" do
    kevin = users(:kevin)
    post :create, email: kevin.email, password: 'wrong'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to login_url
    assert_equal nil, session[:user_id]
  end
  
  test "remember me" do
    delete :destroy
        
    post :create, username: users(:steve).username, password: '7sjy1bss'
    assert_equal users(:steve).id, session[:user_id]
    assert_not_equal users(:steve).remember_token, cookies[:remember_token]
    
    post :create, username: users(:steve).username, password: '7sjy1bss', remember: 'yes'
    assert_equal users(:steve).id, session[:user_id]
    assert_equal users(:steve).remember_token, cookies[:remember_token]
  end
end
