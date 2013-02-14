class BulkSuppliesController < ApplicationController
  before_filter :authorize_user_type, :load_factory
  before_filter :load_store, :load_supplier_data, except: :index
  layout false, only: :fetch_form

  include SupplyManager

  def index
  end
  
  def new
    @supplies = []
    @supplied_on = Time.now.strftime("%Y-%m-%d")
    supplier_products.each { |product| @supplies << supplier.supplies.build(product: product) }
  end
    
  def create
    @supplies = []
    @supplied_on = params[supplier_param][:supplied_on]

    supplier_products.each.with_index do |product, i|
      @supplies << supplier.supplies.build(params[supplier_param][:supplies_attributes][i.to_s].merge(store_id: @store.id, supplied_on: @supplied_on))
    end

    if supplier.save
      redirect_to supplier_success_path, flash: {success: "Supply items for #{@supplied_on.to_date.strftime('%B %d, %Y')} were added for #{@store.name}."}
    else
      render 'new'
    end
  end
  
  def edit
    @supplied_on = Time.now.strftime("%Y-%m-%d")
    @supplies = supplier.fetch_supplies(params[:store_id], Date.today)
  end
  
  def update
    @supplies = []
    @supplied_on = params[supplier_param][:supplied_on]

    Supply.transaction do
      params[supplier_param][:supplies_attributes].values.each do |supply_attributes|
        supply = supplier.supplies.find_by_id(supply_attributes[:id])
        unless supply.update_attributes(quantity: supply_attributes[:quantity])
          supplier.errors.clear
          supplier.errors.add(:supplies_attributes, "Supplies quantity should be a number")
        end
        @supplies << supply
      end
    end

    unless supplier.errors.any?
      redirect_to supplier_success_path, flash: {success: "Supply items for #{@supplied_on.to_date.strftime('%B %d, %Y')} were added for #{@store.name}"}
    else
      render 'edit'
    end
  end

  def fetch_form
    @supplied_on = params[:date]

    @supplies = if supplier_has_supplied_on?(@supplied_on)
      @form_options = { url: @supplier_bulk_supplies_path, method: :put }
      supplier.fetch_supplies(params[:store_id], params[:date])
    else
      @form_options = { url: @supplier_bulk_supplies_path, method: :post }
      supplier_products.map { |product| supplier.supplies.build(product: product) }
    end
  end

  protected

  def authorize_user_type
    render file: 'public/401.html', status: :unauthorized unless logged_in_as_factory_manager? || logged_in_as_store_manager?
  end

  private

  def load_factory
    @factory = Factory.find(params[:factory_id]) if params[:factory_id].present?
  end

  def load_store
    @store = Store.find(params[:store_id])
  end

  def load_supplier_data
    @supplier = @factory.present? ? @factory : @store
    @supplier_bulk_supplies_path = supplier_bulk_supplies_path
    @supplier_fetch_form_path = supplier_fetch_form_path
  end
end
