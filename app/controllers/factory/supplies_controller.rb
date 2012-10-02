class Factory::SuppliesController < ApplicationController  
  def index
    @factory = current_user.factory
  end
  
  def new
    @supplies = []
    @factory = current_user.factory
    @store = Store.find(params[:store_id])
    @factory.products.count.times { @supplies << @factory.supplies.build }
  end
    
  def create
    @supplies = []
    @factory = current_user.factory
    @store = Store.find(params[:store_id])
    
    params[:factory][:supplies_attributes].each_value.with_index do |attributes, index|
      @supplies << @factory.supplies.build(store_id: @store.id,
                              product_id: @store.products[index].id,
                              quantity: make_validation_friendly(attributes[:quantity]),
                              supplied_on: Date.today)
    end
        
    if @factory.save
      redirect_to factory_supplies_path, flash: {success: "Supply items were added for #{@store.name}"}
    else
      render "new"
    end
  end
  
  def edit
    @factory = current_user.factory
    @store = Store.find(params[:id])
    @supplies = @factory.supplies.where(store_id: @store.id, supplied_on: Date.today)
  end
  
  def update
    @factory = current_user.factory
    @store = Store.find(params[:id])
    @supplies = @factory.supplies.where(store_id: @store.id, supplied_on: Date.today)
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
      render "edit"
    end
  end
  
  protected

    def authorize
      render nothing: true unless logged_in_as_factory_guy?
    end
end