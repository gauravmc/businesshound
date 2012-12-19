class Factory::SuppliesController < ApplicationController
  before_filter :authorize_user_type, :load_factory
  layout false, only: :fetch_form

  def index
  end
  
  def new
    @supplies = []
    @store = Store.find(params[:store_id])
    @supplied_on = Time.now.strftime("%Y-%m-%d")
    @factory.products.each { |product| @supplies << @factory.supplies.build(product: product) }
  end
    
  def create
    @supplies = []
    @store = Store.find(params[:store_id])
    @supplied_on = params[:factory][:supplied_on]

    @factory.products.each.with_index do |product, i|
      @supplies << @factory.supplies.build(
        store_id: @store.id,
        product_id: product.id,
        quantity: make_validation_friendly(params[:factory][:supplies_attributes][i.to_s][:quantity]),
        supplied_on: @supplied_on
      )
    end
    
    if @factory.save
      redirect_to factory_supplies_path, flash: {success: "Supply items were added for #{@store.name}"}
    else
      render 'new'
    end
  end
  
  def edit
    @store = Store.find(params[:id])
    @supplied_on = Time.now.strftime("%Y-%m-%d")
    @supplies = @factory.supplies.where(store_id: params[:id], supplied_on: Date.today)
  end
  
  def update
    @store = Store.find(params[:id])
    @supplied_on = params[:factory][:supplied_on]
    @supplies = @factory.supplies.where(store_id: @store.id, supplied_on: @supplied_on)
    supplies_enum = params[:factory][:supplies_attributes].to_enum
    
    @supplies.each do |supply|
      unless supply.update_attributes(quantity: make_validation_friendly(supplies_enum.next[1][:quantity]))
        @factory.errors.clear
        @factory.errors.add(:supplies_attributes, "Supplies quantity should be a number")
      end
    end
        
    unless @factory.errors.any?
      redirect_to factory_supplies_path, flash: {success: "Supply items were added for #{@store.name}"}
    else
      render 'edit'
    end
  end

  def fetch_form
    @supplied_on = params[:date]
    @supplies = @factory.supplies.where(store_id: params[:store_id], supplied_on: params[:date]) || []
    if @supplies.empty?
      @factory.products.each { |product| @supplies << @factory.supplies.build(product: product) }
      @form_options = { url: factory_supplies_path(store_id: params[:store_id]), method: :post }
    else
      @form_options = { url: factory_supply_path(params[:store_id]), method: :put }
    end
  end

  protected

  def authorize_user_type
    render file: 'public/401.html', status: :unauthorized unless logged_in_as_factory_manager?
  end

  private

  def load_factory
    @factory = current_user.factory
  end
end
