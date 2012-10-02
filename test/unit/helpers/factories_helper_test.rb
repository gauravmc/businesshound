require 'test_helper'

class FactoriesHelperTest < ActionView::TestCase
  test "supply quantity" do
   assert_equal supplies(:one).quantity, supply_quantity(supplies(:one))
   assert_equal '', supply_quantity(supplies(:zero))
   assert_equal '', supply_quantity(nil)
  end
end