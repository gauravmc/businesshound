module ApplicationHelper
  def user_friendly(value)
    if value.present? && value.zero?
    	nil
    else
    	value
    end
  end
end
