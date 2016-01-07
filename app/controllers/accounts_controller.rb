class AccountsController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_cooperative
  before_filter :ensure_cooperative_admin
  before_filter :set_user, only: [:destroy]

  def index
    page = params[:page] || 1
    @search_form = SearchAccountsPresenter.new(params)
    query = @search_form.query || ''
    search = Search.new(@cooperative)
    @users = search.search_accounts(page: page, query: query)
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(account_params)
    if @user.save
      @cooperative.users << @user
      flash[:info] = t('accounts.saved_user', email: @user.email)
      redirect_to new_cooperative_account_path(@cooperative)
    else
      render 'new'
	  end
  end

  def destroy
    email = @user.email
    @user.destroy
    flash[:info] = t('accounts.destroyed_user', email: email)
  	redirect_to cooperative_accounts_path
  end

  private

  def set_user
    @user = @cooperative.users.find_by_id(params[:id])
    record_exists?(@user)
  end

  def account_params
    params.require(:user).permit(:email, :password, :role, :password_confirmation)
  end

end
