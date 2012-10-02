require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = {
      fullname: 'Some Full Name',
      email: 'new.email@gmail.com',
      username: 'new_username',
      password: 'abc123456',
      password_confirmation: 'abc123456',
      user_type: 'admin'
    }
  end
  
  test "user attributes must not be empty" do
    user = User.new
    assert user.invalid?
    assert user.errors[:username].any?
    assert !user.save
  end
  
  test "email validation" do    
    Company.creating_new = true
    
    user = User.new(@user)
    user.email = ""
    assert user.invalid?
    assert user.errors[:email].any?

    Company.creating_new = false
    
    user = User.new(@user)
    user.email = ""
    assert user.valid?
  end
    
  test "email formatting" do
    Company.creating_new = true
    
    good = ["gaurav.chande@gmail.com", "david@donuts.com", "humming@birds.co.in", "cadbury_oreo@oreo.co"]
    bad = ["one.two.three", "gaurav@mahendra_chande_com.hk", "simplestring", "chunky@bacon"]
    
    good.each do |email|
      assert user_with_email(email).valid?
    end
    
    bad.each do |email|
      assert user_with_email(email).invalid?
      assert "is invalid", user_with_email(email).errors[:email].join('; ')
    end    
  end
  
  test "user has unique username" do
    user = User.new(@user)
    user.username = users(:steve).username
                    
    assert user.invalid?
    assert "#{users(:steve).username} already exists", user.errors[:fullname].join('; ')
  end
  
  test "username formatting" do
    good = ["gaurav_chande", "daviddonuts", "hummingbirds55", "o_0"]
    bad = ["one.two.three", "gaurav@mahendra_chande_com.hk", "1231244", "my "]
    
    good.each do |username|
      assert user_with_username(username).valid?
    end
    
    bad.each do |username|
      assert user_with_username(username).invalid?
      assert "is invalid", user_with_email(username).errors[:username].join('; ')
    end    
  end
  
  test "password length" do
    user = User.new(fullname: "Some Full Name",
                    username: "New Username",
                    password: "abc12",
                    password_confirmation: "abc12")
                    
    assert user.invalid?
    assert user.errors[:password].any?
    assert !user.save
    assert "is too short (minimum is 6 characters)", user.errors[:password].join('; ')
  end
  
  test "user authenticate" do
    user = users(:steve)
    assert !user.authenticate("wrongpassword")
    assert user.authenticate("7sjy1bss")
  end
  
  test "remember token" do
    user = User.new(@user)
    user.save
    assert_not_nil user.remember_token
  end
  
  def user_with_email(email)
    user = User.new(@user)
    user.email = email
    user
  end
  
  def user_with_username(username)
    user = User.new(@user)
    user.username = username
    user    
  end
end
