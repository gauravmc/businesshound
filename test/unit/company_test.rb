require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "company attributes should not be empty" do
    company = Company.new
    assert company.invalid?
    assert !company.save
    assert company.errors.any?
    assert company.errors[:name].any?
    assert company.errors[:currency].any?
    assert_equal "is required", company.errors[:name].join('; ')
    assert_equal "is required", company.errors[:currency].join('; ')
  end
end
