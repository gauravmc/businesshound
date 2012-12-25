class Admin::FactoriesController < Admin::AdminController  
  def index
    @factories = Factory.where(company_id: current_company.id).order :name
  end
  
  def new
    @factory = Factory.new
    @user = User.new
  end
  
  def create
    params[:factory][:stores].collect! { |id| Store.find_by_id(id) } unless params[:factory][:stores].nil?
    
    @factory = current_company.factories.build params[:factory]
    @user = @factory.build_manager params[:user].merge(user_type: "factory", company: current_company)

    if @factory.valid? & @user.valid?
      @user.save validate: false
      @factory.save validate: false
      redirect_to admin_factories_path, flash: {success: "#{@factory.name} was successfully added."}
    else
      render action: "new"
    end
  end
  
  def edit
    @factory = Factory.find(params[:id])
  end
  
  def update
    if params[:factory][:stores].nil?
      params[:factory][:stores] = []
    else
      params[:factory][:stores].collect! { |id| Store.find_by_id(id) }
    end
    
    @factory = Factory.find(params[:id])    

    if @factory.update_attributes(params[:factory])
      redirect_to admin_factories_path, flash: {success: "Factory was successfully updated."}
    else
      render "edit"
    end
  end
  
  def destroy
    Factory.find(params[:id]).destroy
    flash[:success] = "Factory successfully deleted."
    respond_to do |format|
      format.html { redirect_to admin_factories_path }
    end
  end
end
