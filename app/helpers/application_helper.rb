module ApplicationHelper
  def make_validation_friendly(value)
    value == "" ? 0 : value
  end
end
