require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase
  setup do
    @product_attributes = {
      name: "Khari",
      price: 0.01
    }
    
    @update = {
      name: "Soap",
      price: 1.01
    }
  end
  
  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @product_attributes
    end
    assert_redirected_to admin_products_path
  end
  
  test "should update product" do
    put :update, id: products(:iphone).to_param, product: @update
    assert_redirected_to admin_products_path
  end
end