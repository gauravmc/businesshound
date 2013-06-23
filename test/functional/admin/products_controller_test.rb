require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase
  setup do
    @product_attributes = {
      name: "Khari",
      kind: 'produced',
      price: 0.01
    }
    
    @update = {
      name: "Soap",
      kind: 'traded',
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

  test "sort should update product positions" do
    ids = companies(:apple).products.map(&:id).shuffle
    put :sort, product: ids

    assert_equal ids, companies(:apple).reload.products.map(&:id)
  end

  test "acts_as_list sets the position correctly" do
    product = companies(:apple).products.create(name: 'Mac Pro', price: 1000, kind: 'produced')

    assert_equal 4, product.position
  end
end
