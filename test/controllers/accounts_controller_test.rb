require 'test_helper'

class AccountsControllerTest < ActionController::TestCase

  test "should get index for cooperative_admin" do
  	@user = users(:cooperative_admin_user)
  	sign_in @user
    get :index, cooperative_id: @user.cooperative.id
    assert_response :success
    # sign_out user
  end

  test "should not get index for foreman" do
    @user = users(:foreman_user)
    sign_in @user
    get :index, cooperative_id: @user.cooperative.id
    assert_response 401
    # sign_out user
  end

  teardown do
    sign_out @user
  end

end
