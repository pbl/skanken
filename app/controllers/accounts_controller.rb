class AccountsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_cooperative_admin?

  def index
  	@cooperative = Cooperative.find(current_user.cooperative_id)
		@users = @cooperative.users.all
  end

  def new
  	@cooperative = Cooperative.find(current_user.cooperative_id)
  end
  
  def create 
  	@cooperative = Cooperative.find(current_user.cooperative_id)
    email = params[:account][:email]
    password = params[:account][:password]
    merge_params = account_params.merge(:password_confirmation => password)  
  	@user = User.new(:email => params[:account][:email], :password => params[:account][:password], :password_confirmation => params[:account][:password])
  	@user.user_role = params[:account][:user_role].to_i
    if @cooperative.users << @user
      flash[:success] = "The user with an email: #{email} and password: #{password} has been created. Helge vare gösta"
    else
      flash[:danger] = "The email adress might already be in use or a form field wasn't filled in. Helge vare gösta"
	  end
  	redirect_to new_cooperative_account_path(@cooperative)
  end

  def destroy
  	@cooperative = Cooperative.find(current_user.cooperative_id)
  	@user = @cooperative.users.find(params[:id])
  	@user.destroy
  	redirect_to cooperative_accounts_path
  end

  private
    def account_params
      params.require(:account).permit(:email, :password)
    end

end
