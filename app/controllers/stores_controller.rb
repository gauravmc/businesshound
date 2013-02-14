class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
    @date = params[:date] || Date.today
  end
end
