class AdminController < ApplicationController
  def index
    @stores = Store.all
    @store = @stores.find {|s| s.id == params[:store_id].to_i} || @stores.first
    @date = date
  end
end
