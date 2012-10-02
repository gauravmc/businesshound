require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert !product.save
    assert product.errors[:name].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do
    product = Product.new(name: "My Product name")
    product.price = -1
    assert product.invalid?
    assert_equal "should be more than 0", product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "should be more than 0", product.errors[:price].join('; ')

    product.price = 1
    assert product.valid?
  end
  
  test "product not valid without unique name for same company" do
    product = Product.new(name: products(:iphone).name,
                          price: 12, 
                          company_id: companies(:apple).id)
    assert !product.save
    assert_equal "#{products(:iphone).name} already exists", product.errors[:name].join('; ')
  end

  test "product valid without unique name for different company" do
    product = Product.new(name: products(:iphone).name,
                          price: 12, 
                          company_id: companies(:mod).id)
    assert product.save
    assert_equal "", product.errors[:name].join('; ')
  end
end
