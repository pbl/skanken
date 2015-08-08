class AccountsController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_cooperative

  def index
		@users = @cooperative.users
  end

  def new
  end

  def create
    email = params[:account][:email]
    password = params[:account][:password]
    merge_params = account_params.merge(:password_confirmation => password)
  	@user = User.new(:email => params[:account][:email], :password => params[:account][:password], :password_confirmation => params[:account][:password])
  	@user.role = params[:account][:role]
    if @cooperative.users << @user
      flash[:success] = "The user with an email: #{email} and password: #{password} has been created. Helge vare gösta"
    else
      flash[:danger] = "The email adress might already be in use or a form field wasn't filled in. Helge vare gösta"
	  end
  	redirect_to new_cooperative_account_path(@cooperative)
  end

  def destroy
  	@user = @cooperative.users.find(params[:id])
  	if @user.destroy
      flash[:success] = "Account was succesfully removed. Helge vare gösta"
    else
      flash[:danger] = "Something went wrong. Helge vare gösta"
    end
  	redirect_to cooperative_accounts_path
  end

  private
    def account_params
      params.require(:account).permit(:email, :password)
    end

end
