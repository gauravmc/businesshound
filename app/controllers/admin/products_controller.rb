class Admin::ProductsController < ApplicationController
  def index
    @products = Product.where("company_id = #{current_company.id}").all(order: :created_at)
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    @product.company_id = current_company.id
    if @product.save
      redirect_to admin_products_path, flash: {success: "#{@product.name} was successfully added."}
    else
      render "new"  
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to admin_products_path, flash: {success: "Product was successfully updated."}
    else
      render "edit"  
    end
  end
  
  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product destroyed."
    respond_to do |format|
      format.html { redirect_to admin_products_path }
      format.js
    end
  end

  protected

    def authorize
      render nothing: true unless logged_in_as_admin?
    end  
end