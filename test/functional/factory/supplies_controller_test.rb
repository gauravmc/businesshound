require 'test_helper'

class Factory::SuppliesControllerTest < ActionController::TestCase
  setup do
    @store = stores(:apple_store)

    @valid_supply = { supplies_attributes: {
      "0" => { quantity: 321 },
      "1" => { quantity: 31 }
      },
      supplied_on: '2012-12-19'
    }
    
    @invalid_supply = { supplies_attributes: {
      "0" => { quantity: "asb" },
      "1" => { quantity: 31 }
      },
      supplied_on: '2012-12-19'
    }
    
    @empty_supply = { supplies_attributes: {
      "0" => { quantity: nil },
      "1" => { quantity: nil }
      },
      supplied_on: '2012-12-19'
    }
  end
  
  test "should create valid supplies" do
    assert_difference('Supply.count', 2) do
      post :create, factory: @valid_supply, store_id: @store.id
    end
    assert_equal '2012-12-19', Supply.last.supplied_on.to_s
  end
  
  test "should not create invalid supplies" do
    assert_no_difference('Supply.count') do
      post :create, factory: @invalid_supply, store_id: @store.id
    end
  end

  test "should update to valid supplies" do
    assert_no_difference('Supply.count') do
      put :update, factory: @valid_supply, id: @store.id
    end
    assert_equal 321, supplies(:one).quantity
    assert_equal 31, supplies(:zero).quantity
  end

  test "should not update to invalid supplies" do
    assert_no_difference('Supply.count') do
      put :update, factory: @invalid_supply, id: @store.id
    end
    assert_equal 45, supplies(:one).quantity
    assert_equal 31, supplies(:zero).quantity
  end
    
  def setup
    super
    log_in users(:apple_factory_manager)
  end
end
