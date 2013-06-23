class Admin::ProductsController < Admin::AdminController
  def index
    @products = Product.where(company_id: current_company.id).order :name
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
    flash[:success] = "Product successfully deleted."
    respond_to do |format|
      format.html { redirect_to admin_products_path }
      format.js
    end
  end

  def sort
    params[:product].each.with_index do |id, i|
      current_company.products.update_all({ position: i + 1 }, { id: id })
    end
    render nothing: true
  end
end
