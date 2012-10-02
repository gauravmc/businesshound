require 'test_helper'

class Admin::FactoriesControllerTest < ActionController::TestCase
  setup do
    @factory_attributes = {
      name: 'Some Factory Name',
      stores: [companies(:apple).stores.first.name]
    }
    
    @user_attributes = {
      fullname: 'Lorem Ipsum',
      email: 'lorem.ipsum@gmail.com',
      username: 'loremipsum',
      password: 'abc123456',
      password_confirmation: 'abc123456',
    }
    
    @update = {
      name: 'New Factory Name',
      stores: [companies(:apple).stores.first.name]
    }
  end
  
  test "should create factory" do
    assert_difference ['Factory.count', 'User.count'] do
      post :create, factory: @factory_attributes, user: @user_attributes
    end
    
    assert_redirected_to admin_factories_path
  end
  
  test "should update factory" do
    put :update, id: factories(:apple_factory).to_param, factory: @update
    assert_redirected_to admin_factories_path
  end
end