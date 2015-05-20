require 'test_helper'

class InfoControllerTest < ActionController::TestCase

  test "should get index for all users" do
  	USERS = %w[default_user foreman_user cooperative_admin_user admin_user]
  	USERS.each do |user|
  		test_index user
  	end
  end

  private
  	def test_index users
  		sign_in users
	    get :about
	    assert_response :success
	    assert_template :about
		  assert_template layout: "layouts/application"
	    sign_out users
  	end

end
