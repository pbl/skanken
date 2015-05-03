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
  	@user = User.new(:email => params[:account][:email], :password => params[:account][:password], :password_confirmation => params[:account][:password])
  	@user.user_role = params[:account][:user_role].to_i
  	@cooperative.users << @user
  	@cooperative.save
  	redirect_to new_cooperative_account_path(@cooperative)
  end

end
