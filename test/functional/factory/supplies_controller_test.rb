require 'test_helper'

class Factory::SuppliesControllerTest < ActionController::TestCase
  setup do    
    @valid_supply = { supplies_attributes: {
      "0" => { quantity: 321 },
      "1" => { quantity: 31 }
    }}
    
    @invalid_supply = { supplies_attributes: {
      "0" => { quantity: "asb" },
      "1" => { quantity: 31 }
    }}
    
    @empty_supply = { supplies_attributes: {
      "0" => { quantity: nil },
      "1" => { quantity: nil }
    }}
  end
  
  test "should create valid supplies" do
    assert_difference('Supply.count', 2) do
      post :create, factory: @valid_supply, store_id: stores(:apple_store).id
    end
  end
  
  test "should not create invalid supplies" do
    assert_no_difference('Supply.count') do
      post :create, factory: @invalid_supply, store_id: stores(:apple_store).id
    end
  end
    
  def setup
    super
    log_in users(:apple_factory_manager)
  end
end