require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  test "store attributes must not be empty" do
    store = Store.new
    assert store.invalid?
    assert !store.save
    assert store.errors[:name].any?
  end
  
  test "store name must be unique" do
    store = Store.new(name: stores(:apple_store).name,
                      company_id: companies(:apple).id)
    assert store.invalid?
    assert !store.save
    assert_equal "#{stores(:apple_store).name} already exists", store.errors[:name].join('; ')
    
    store.name = "Some Different Name"
    assert store.valid?
  end
end
