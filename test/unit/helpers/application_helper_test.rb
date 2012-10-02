require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "make validation friendly" do
    assert_equal 0, make_validation_friendly("")
    assert_equal 0, make_validation_friendly(0)
    assert_equal 123, make_validation_friendly(123)
    assert_equal "abc", make_validation_friendly("abc")
  end
end