require 'test_helper'

class SupplyTest < ActiveSupport::TestCase
  test "Product cannot be supplied more than once from a factory to a store on a given date" do
    existing_supply = supplies(:one)
    supply = existing_supply.dup
    supply.save
    assert_equal ["Product entry already made for given date."], supply.errors.full_messages
  end
end
