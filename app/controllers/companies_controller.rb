class CompaniesController < ApplicationController
  skip_before_filter :authorize
  
  def new
    @company = Company.new
    @user = User.new
  end  
  
  def create
    Company.creating_new = true
    @company = Company.new(params[:company])
    @user = User.new params[:user].merge(user_type: "admin")
            
    if @company.valid? & @user.valid?
      if @company.save(validate: false)
        @user.company_id = @company.id
        @user.save(validate: false)
      end
      redirect_to login_url, flash: {success: "Company #{@company.name} was successfully created. 
                                      Start using BusinessHound now!"}
    else
      render action: "new"
    end
    Company.creating_new = false
  end
end