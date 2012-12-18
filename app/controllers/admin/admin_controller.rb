class Admin::AdminController < ApplicationController
	before_filter :authorize_user_type

	protected

	def authorize_user_type
    render file: 'public/401.html', status: :unauthorized unless logged_in_as_admin?
	end
end
