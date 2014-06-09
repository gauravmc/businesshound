class AdminController < ApplicationController
  def index
    @stores = current_company.stores
    @store = @stores.find {|s| s.id == params[:store_id].to_i} || @stores.first
    @date = date
  end
end
