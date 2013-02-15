class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
    @date = date
  end
end
