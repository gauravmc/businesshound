require 'test_helper'

class Admin::StoresControllerTest < ActionController::TestCase
  setup do
    @store_attributes = {
      name: 'Apple Store Cupertino',
    }
    
    @user_attributes = {
      fullname: 'Lorem Ipsum',
      email: 'lorem.ipsum@gmail.com',
      username: 'loremipsum',
      password: 'abc123456',
      password_confirmation: 'abc123456',
    }
  end
  
  test "should create store" do
    assert_difference ['Store.count', 'User.count'] do
      post :create, store: @store_attributes, user: @user_attributes
    end
    assert_redirected_to admin_stores_path
  end
end