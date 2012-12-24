require 'test_helper'

class FactoryTest < ActiveSupport::TestCase
  setup do
    @supply_attributes = { supplies_attributes: {
      "0" => { quantity: 321, supplied_on: '2012-12-19', product: products(:donut), store: stores(:mod_mumbai) },
      "1" => { quantity: 31, supplied_on: '2012-12-19', product: products(:coffee), store: stores(:mod_mumbai) }
    }}
  end
  
  test "factory attributes must not be empty" do
    factory = companies(:apple).factories.build
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
  
  test "should accept attributes for supplies" do
    factory = factories(:mod_factory)

    factory.update_attributes(@supply_attributes)
    assert_equal 2, factory.supplies.count
  end

  test "manager destroyed when factory is destroyed" do
    manager_id = users(:apple_factory_manager).id
    factories(:apple_factory).destroy
    assert !User.find_by_id(manager_id).present?
  end
end
