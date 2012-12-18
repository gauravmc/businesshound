class Admin::StoresController < Admin::AdminController  
  def index
    @stores = Store.where("company_id = #{current_company.id}").all(order: :created_at)
  end

  def new
    @store = Store.new
    @user = User.new
  end
  
  def create
    @store = Store.new params[:store].merge(company_id: current_company.id)
    @user = User.new params[:user].merge(user_type: "store", company_id: current_company.id)

    if @store.valid? & @user.valid?
      @store.save(validate: false)
      @user.save(validate: false)
      redirect_to admin_stores_path, flash: {success: "#{@store.name} was successfully added."}
    else
      render action: "new"
    end
  end
  
  def edit
    @store = Store.find(params[:id])
  end
  
  def update
    @store = Store.find(params[:id])

    if @store.update_attributes(params[:store])
      redirect_to admin_stores_path, flash: {success: "Store was successfully updated."}
    else
      render "edit"  
    end
  end
  
  def destroy
    Store.find(params[:id]).destroy
    flash[:success] = "Store destroyed."
    respond_to do |format|
      format.html { redirect_to admin_stores_path }
    end
  end
end
