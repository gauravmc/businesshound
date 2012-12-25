require 'test_helper'

class Admin::StoresControllerTest < ActionController::TestCase
  setup do
    @store_attributes = {
      name: 'Apple Store New',
      factories: [factories(:apple_factory).id]      
    }
    
    @user_attributes = {
      fullname: 'Lorem Ipsum',
      email: 'lorem.ipsum@gmail.com',
      username: 'loremipsum',
      password: 'abc123456',
      password_confirmation: 'abc123456',
    }
  end
  
  test "should create store when valid attributes provided" do
    assert_difference ['Store.count', 'User.count'] do
      post :create, store: @store_attributes, user: @user_attributes
    end
    assert_redirected_to admin_stores_path
    assert flash[:success]
  end

  test "should not create store with invalid attributes" do
    assert_no_difference ['Store.count', 'User.count'] do
      post :create, store: {}, user: @user_attributes
    end
    assert !flash[:success]
    assert assigns(:store).errors.any?
  end

  test "should not update store if no supply factory selected" do
    store = stores(:apple_store)
    post :update, id: store.id, store: { name: store.name }

    assert !flash[:success]
    assert assigns(:store).errors.any?
  end
end
