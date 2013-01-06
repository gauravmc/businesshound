require 'test_helper'

class BulkSuppliesControllerTest < ActionController::TestCase
  setup do
    @store = stores(:apple_store)
    @factory = factories(:apple_factory)

    @valid_supplies = { supplies_attributes: {
      "0" => { quantity: 321, product_id: products(:iphone).id },
      "1" => { quantity: 31, product_id: products(:ipad).id },
      "2" => { quantity: 31, product_id: products(:ipod).id }
    }}
    
    @invalid_supplies = { supplies_attributes: {
      "0" => { quantity: 'abc', product_id: products(:iphone).id },
      "1" => { quantity: 'foo', product_id: products(:ipad).id },
      "2" => { quantity: 31, product_id: products(:ipod).id }
    }}
  end
  
  test "should create valid supplies" do
    assert_difference('Supply.count', 3) do
      post :create, factory_id: @factory.id, factory: @valid_supplies.merge(supplied_on: '2012-12-19'), store_id: @store.id
    end
    assert_equal '2012-12-19', Supply.last.supplied_on.to_s
    assert_equal 321, Supply.where(product_id: products(:iphone).id).last.quantity
  end
  
  test "should not create invalid supplies" do
    assert_no_difference('Supply.count') do
      post :create, factory_id: @factory.id, factory: @invalid_supplies.merge(supplied_on: Date.today), store_id: @store.id
    end
  end

  test "should update to valid supplies" do
    assert_no_difference('Supply.count') do
      put :update, factory_id: @factory.id, factory: @valid_supplies.merge(supplied_on: Date.today), store_id: @store.id
    end
    assert_equal 321, supplies(:one).quantity
    assert_equal 31, supplies(:zero).quantity
  end

  test "should not update to invalid supplies" do
    assert_no_difference('Supply.count') do
      put :update, factory_id: @factory.id, factory: @invalid_supplies.merge(supplied_on: Date.today), store_id: @store.id
    end
    assert_equal 45, supplies(:one).quantity
    assert_equal 0, supplies(:zero).quantity
  end
    
  def setup
    super
    log_in users(:apple_factory_manager)
  end
end
