require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  test "store attributes must not be empty" do
    store = companies(:apple).stores.build
    assert store.invalid?
    assert !store.save
    assert store.errors[:name].any?
  end
  
  test "store name must be unique" do
    store = companies(:apple).stores.build(name: stores(:apple_store).name)
    assert store.invalid?
    assert !store.save
    assert_equal "#{stores(:apple_store).name} already exists", store.errors[:name].join('; ')
    
    store.name = "Some Different Name"
    store.valid?
    assert !store.errors[:name].present?
  end

  test "manager destroyed when store is destroyed" do
    manager_id = users(:apple_store_manager).id
    stores(:apple_store).destroy
    assert !User.find_by_id(manager_id).present?
  end

  test "fetch_stocks creates 0 quantity stocks for missing products before returning" do
    stocks = stores(:apple_store).fetch_stocks Date.today
    assert_equal 0, stores(:apple_store).stocks.where(product_id: products(:ipad).id).pop.quantity
  end
end
