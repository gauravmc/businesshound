class StoreController < ApplicationController
  def index
    redirect_to store_stocks_path
  end
end
