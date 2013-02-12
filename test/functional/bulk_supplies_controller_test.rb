require 'test_helper'

class BulkSuppliesControllerTest < ActionController::TestCase
  setup do
    @store = stores(:apple_store)
    @factory = factories(:apple_factory)

    @valid_supplies = { supplies_attributes: {
      "0" => { quantity: 321, product_id: products(:iphone).id },
      "1" => { quantity: 31, product_id: products(:ipad).id },
      "2" => { quantity: 51, product_id: products(:ipod).id }
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

  test "should create valid trading product supplies for store" do
    @store.products.each do |product|
      product.update_attribute :kind, 'traded'
      product.save!
    end #had to do this coz #update_all has a bug with default scope in rails 3.2

    log_in users(:apple_store_manager)

    assert_difference('Supply.count', 3) do
      post :create, store: @valid_supplies.merge(supplied_on: '2012-12-19'), store_id: @store.id
    end
    assert_equal 321, @store.supplies.last(3).first.quantity
    assert_equal 51, @store.supplies.last.quantity
  end

  test "should update to valid supplies" do
    valid_supplies = { supplies_attributes: {
      "0" => { quantity: 321, product_id: products(:iphone).id, id: supplies(:one).id },
      "1" => { quantity: 31, product_id: products(:ipad).id, id: supplies(:zero).id },
      "2" => { quantity: 31, product_id: products(:ipod).id, id: supplies(:three).id }
    }}

    assert_no_difference('Supply.count') do
      put :update, factory_id: @factory.id, factory: valid_supplies.merge(supplied_on: Date.today), store_id: @store.id
    end
    assert_equal 321, supplies(:one).reload.quantity
    assert_equal 31, supplies(:zero).reload.quantity
  end

  test "should not update to invalid supplies" do
    invalid_supplies = { supplies_attributes: {
      "0" => { quantity: 'abc', product_id: products(:iphone).id, id: supplies(:one).id },
      "1" => { quantity: 'foo', product_id: products(:ipad).id, id: supplies(:zero).id },
      "2" => { quantity: 31, product_id: products(:ipod).id, id: supplies(:three).id }
    }}

    assert_no_difference('Supply.count') do
      put :update, factory_id: @factory.id, factory: invalid_supplies.merge(supplied_on: Date.today), store_id: @store.id
    end
    assert_equal ["Supplies quantity should be a number"], assigns(:supplier).errors[:supplies_attributes]
    assert_equal 45, supplies(:one).reload.quantity
    assert_equal 0, supplies(:zero).reload.quantity
  end
    
  def setup
    super
    log_in users(:apple_factory_manager)
  end
end
