class StoresController < ApplicationController
  def show
    redirect_to store_bulk_stocks_url(params[:id])
  end
end
