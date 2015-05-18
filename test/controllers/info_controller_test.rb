require 'test_helper'

class InfoControllerTest < ActionController::TestCase

  test "should get index" do
  	sign_in users :default_user
    get :about
    assert_response :success
    assert_template :about
	  assert_template layout: "layouts/application"
    sign_out :joe
  end

end
