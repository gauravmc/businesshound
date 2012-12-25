require 'test_helper'

class StockTest < ActiveSupport::TestCase
	test "quantity made validation friendly before validation" do
		stock = Stock.new(quantity: '')
		stock.valid?
		assert_equal 0, stock.quantity
	end
end
