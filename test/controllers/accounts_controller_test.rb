require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get index for cooperative_admin" do
  	user = users(:cooperative_admin_user)
  	sign_in user
  	cooperative = cooperatives(:cooperative)
  	cooperative.users << user
    get :index, :cooperative_id => cooperative.id
    assert_response :success
    assert_template :index
	  assert_template layout: "layouts/application"
    sign_out :cooperative_admin
  end

end
