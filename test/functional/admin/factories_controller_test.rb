require 'test_helper'

class Admin::FactoriesControllerTest < ActionController::TestCase
  setup do
    @factory_attributes = {
      name: 'Some Factory Name',
      stores: [stores(:apple_store).id, stores(:apple_store_two).id]
    }

    @user_attributes = {
      fullname: 'Lorem Ipsum',
      email: 'lorem.ipsum@gmail.com',
      username: 'loremipsum',
      password: 'abc123456',
      password_confirmation: 'abc123456',
    }
  end
  
  test "should create factory with valid attributes" do
    assert_difference ['Factory.count', 'User.count'] do
      post :create, factory: @factory_attributes, user: @user_attributes
    end
    
    assert_redirected_to admin_factories_path
    assert flash[:success]
  end

  test "should not create factory with invalid attributes" do
    assert_no_difference ['Factory.count', 'User.count'] do
      post :create, factory: {name: '', stores: []}, user: @user_attributes
    end
    assert !flash[:success]
    assert assigns(:factory).errors.any?
  end

  test "should update factory with valid attributes" do
    put :update, id: factories(:apple_factory).id, factory: {
      name: 'New Factory Name',
      stores: [stores(:apple_store).id, stores(:apple_store_two).id]
    }

    assert_redirected_to admin_factories_path
    assert flash[:success]
    assert factories(:apple_factory).supplies_to? stores(:apple_store_two)
  end

   test "should not update factory if no supply store selected" do
    factory = factories(:apple_factory)
    post :update, id: factory.id, factory: { name: factory.name }

    assert !flash[:success]
    assert assigns(:factory).errors.any?
  end 
end
