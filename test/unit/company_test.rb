require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "company attributes should not be empty" do
    company = Company.new
    assert company.invalid?
    assert !company.save
    assert company.errors.any?
    assert company.errors[:name].any?
    assert company.errors[:business_type].any?
    assert company.errors[:currency].any?
    assert_equal "is required", company.errors[:name].join('; ')
    assert_equal "is required", company.errors[:currency].join('; ')
    assert_equal "must be selected", company.errors[:business_type].join('; ')
  end
  
  test "business type should only contain allowed values" do
    company = Company.new(name: "Some Company", currency: "$")
    company.business_type = "random value"
    assert company.invalid?
    assert_equal "must be selected", company.errors[:business_type].join('; ')
    assert !company.save
    
    company.business_type = "0"
    assert company.invalid?
    assert_equal "must be selected", company.errors[:business_type].join('; ')
    assert !company.save

    company.business_type = "1"
    assert company.valid?
    assert company.save
  end
end
