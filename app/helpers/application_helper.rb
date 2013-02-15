module ApplicationHelper
  def user_friendly(value)
    if value.present? && value.zero?
    	nil
    else
    	value
    end
  end

  def date
  	params[:date] || Time.now.strftime("%Y-%m-%d")
  end
end
