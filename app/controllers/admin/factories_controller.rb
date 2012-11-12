class Admin::FactoriesController < ApplicationController  
  def index
    @factories = Factory.where("company_id = #{current_company.id}").all(order: :created_at)
  end
  
  def new
    @factory = Factory.new
    @user = User.new
  end
  
  def create
    params[:factory][:stores].collect! { |store_name| Store.find_by_name(store_name) } unless params[:factory][:stores].nil?
    
    @factory = Factory.new params[:factory].merge(company_id: current_company.id)
    @user = User.new params[:user].merge(user_type: "factory", company_id: current_company.id)

    if @factory.valid? & @user.valid?      
      @user.save validate: false
      @factory.manager_id = @user.id
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
    params[:factory][:stores].collect! { |store_name| Store.find_by_name(store_name) } unless params[:factory][:stores].nil?
    
    @factory = Factory.find(params[:id])    
    
    if @factory.update_attributes(params[:factory])
      redirect_to admin_factories_path, flash: {success: "Factory was successfully updated."}
    else
      render "edit"  
    end
  end
  
  def destroy
    Factory.find(params[:id]).destroy
    flash[:success] = "Factory destroyed."
    respond_to do |format|
      format.html { redirect_to admin_factories_path }
    end
  end
  
  protected

    def authorize
      render nothing: true unless logged_in_as_admin?
    end
end
