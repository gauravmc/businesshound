class FactoriesController < ApplicationController
  def show
    redirect_to factory_bulk_supplies_url(params[:id])
  end
end
