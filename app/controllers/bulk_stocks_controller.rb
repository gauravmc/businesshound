class BulkStocksController < ApplicationController
  before_filter :authorize_user_type, :load_store
  layout false, only: :fetch_form

  def new
    @stocks = @store.products.map { |product| @store.stocks.build(product: product, left_on: @left_on) }
  end

  def create
    @stocks = []
    @left_on = params[:store][:left_on]

    @store.products.each.with_index do |product, i|
      @stocks << @store.stocks.build(params[:store][:stocks_attributes][i.to_s].merge(left_on: @left_on))
    end

    if @store.save
      redirect_to store_path(@store), flash: {success: "Left-over stock items for #{@left_on.to_date.strftime('%B %d, %Y')} were added for #{@store.name}."}
    else
      render 'new'
    end
  end

  def edit
    @stocks = @store.fetch_stocks Date.today
  end

  def update
    @stocks = []
    @left_on = params[:store][:left_on]

    Stock.transaction do
      params[:store][:stocks_attributes].values.each do |stock_attributes|
        stock = @store.stocks.where(left_on: @left_on, product_id: stock_attributes[:product_id]).first
        unless stock.update_attributes(quantity: stock_attributes[:quantity])
          @store.errors.clear
          @store.errors.add(:stocks_attributes, "Stocks quantity should be a number")
        end
        @stocks << stock
      end
    end

    unless @store.errors.any?
      redirect_to store_path(@store), flash: {success: "Left-over stock items for #{@left_on.to_date.strftime('%B %d, %Y')} were added for #{@store.name}"}
    else
      render 'edit'
    end
  end

  def fetch_form
    @stocks = if @store.has_entered_stock_on?(@left_on)
      @form_options = { url: store_bulk_stocks_path(@store), method: :put }
      @store.fetch_stocks @left_on
    else
      @form_options = { url: store_bulk_stocks_path(@store), method: :post }
      @store.products.map { |product| @store.stocks.build(product: product, left_on: @left_on) }
    end
  end

  protected

  def authorize_user_type
    render file: 'public/401.html', status: :unauthorized unless logged_in_as_store_manager?
  end

  private

  def load_store
    @left_on = date
    @store ||= Store.find(params[:store_id])
  end  
end
