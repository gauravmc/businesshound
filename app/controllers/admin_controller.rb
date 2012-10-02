class AdminController < ApplicationController
  def index
    redirect_to admin_products_path
  end
end
