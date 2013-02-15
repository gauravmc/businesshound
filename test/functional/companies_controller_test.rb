require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company_attributes = {
      name: 'Sample Company',
      currency: 'Rs.',
    }
    
    @user_attributes = {
      fullname: 'Johnny Cage',
      email: 'johnny.cage@gmail.com',
      username: 'sample',
      password: 'abc123456',
      password_confirmation: 'abc123456',
    }
  end
  
  test "should create company" do
    assert_difference ['Company.count', 'User.count'] do
      post :create, company: @company_attributes, user: @user_attributes
    end
    assert_redirected_to admin_path
  end
end