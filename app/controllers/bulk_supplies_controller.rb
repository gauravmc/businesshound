class BulkSuppliesController < ApplicationController
  before_filter :authorize_user_type, :load_factory, :load_store
  layout false, only: :fetch_form

  def index
  end
  
  def new
    @supplies = []
    @supplied_on = Time.now.strftime("%Y-%m-%d")
    @factory.products.each { |product| @supplies << @factory.supplies.build(product: product) }
  end
    
  def create
    @supplies = []
    @supplied_on = params[:factory][:supplied_on]

    @factory.products.each.with_index do |product, i|
      @supplies << @factory.supplies.build(params[:factory][:supplies_attributes][i.to_s].merge(store_id: @store.id, supplied_on: @supplied_on))
    end
    
    if @factory.save
      redirect_to factory_bulk_supplies_url(@factory), flash: {success: "Supply items were added for #{@store.name}."}
    else
      render 'new'
    end
  end
  
  def edit
    @supplied_on = Time.now.strftime("%Y-%m-%d")
    @supplies = @factory.fetch_supplies(params[:store_id], Date.today)
  end
  
  def update
    @supplies = []
    @supplied_on = params[:factory][:supplied_on]

    Supply.transaction do
      params[:factory][:supplies_attributes].values.each do |supply_attributes|
        supply = @factory.supplies.where(store_id: @store.id, supplied_on: @supplied_on, product_id: supply_attributes[:product_id]).first
        unless supply.update_attributes(quantity: supply_attributes[:quantity])
          @factory.errors.clear
          @factory.errors.add(:supplies_attributes, "Supplies quantity should be a number")
        end
        @supplies << supply
      end
    end

    unless @factory.errors.any?
      redirect_to factory_bulk_supplies_url(@factory), flash: {success: "Supply items were added for #{@store.name}"}
    else
      render 'edit'
    end
  end

  def fetch_form
    @supplied_on = params[:date]

    @supplies = if @factory.has_supplied_to_store_on?(@supplied_on, @store)
      @form_options = { url: factory_bulk_supplies_path(@factory, store_id: @store.id), method: :put }
      @factory.fetch_supplies(params[:store_id], params[:date])
    else
      @form_options = { url: factory_bulk_supplies_path(@factory, store_id: @store.id), method: :post }
      @factory.products.map { |product| @factory.supplies.build(product: product) }
    end
  end

  protected

  def authorize_user_type
    render file: 'public/401.html', status: :unauthorized unless logged_in_as_factory_manager?
  end

  private

  def load_factory
    @factory ||= Factory.find(params[:factory_id])
  end

  def load_store
    @store ||= Store.find(params[:store_id]) if params[:store_id].present?
  end
end
