require 'test_helper'

class FactoryTest < ActiveSupport::TestCase
  setup do
    @supply_attributes = { supplies_attributes: {
      "0" => { quantity: 321 },
      "1" => { quantity: 31 }
    }}
  end
  
  test "factory attributes must not be empty" do
    factory = Factory.new
    assert factory.invalid?
    assert !factory.save
    assert factory.errors[:name].any?
  end
  
  test "factory name must be unique" do
    factory = Factory.new(name: factories(:apple_factory).name,
                          company_id: companies(:apple).id,
                          stores: [stores(:apple_store)])
    assert factory.invalid?
    assert !factory.save
    assert_equal "#{factories(:apple_factory).name} already exists", factory.errors[:name].join('; ')
    
    factory.name = "Some Different Name"
    assert factory.valid?
  end
  
  test "factories store record" do
    Factory.create(name: "New Factory",
                  company_id: companies(:apple).id,
                  stores: [stores(:apple_store)])
    factory = Factory.find_by_name("New Factory")
    assert_not_nil factory.stores
    assert factory.stores.include?(stores(:apple_store))
  end
  
  test "should accept attribtues for supplies" do
    factory = factories(:mod_factory)
    assert_equal 0, factory.supplies.count
    factory.update_attributes(@supply_attributes)
    assert_equal 2, factory.supplies.count
  end
end
