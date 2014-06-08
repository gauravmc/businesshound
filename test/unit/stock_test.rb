require 'test_helper'

class StockTest < ActiveSupport::TestCase
	test "quantity made validation friendly before validation" do
		stock = Stock.new(quantity: '')
		stock.valid?
		assert_equal 0, stock.quantity
	end

  test "supply_quantity returns total product quantity supplied on stock's left_on date" do
    stock = stocks(:one)
    assert_equal 45, stock.supply_quantity
  end

  test "supply_quantity is zero when there are no supply records" do
    stock = stocks(:one)
    Supply.where(product_id: stock.product.id).delete_all
    assert_equal 0, stock.supply_quantity
  end

  test "supply_quantity considers all supplies from different factories to the store" do
    stock = stocks(:one)
    stock.product.supplies.create!(factory: factories(:apple_factory_two), store: stock.store, quantity: 30, supplied_on: stock.left_on)
    assert_equal 75, stock.supply_quantity
  end
end
