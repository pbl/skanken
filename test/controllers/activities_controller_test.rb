require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase

  setup do
    @user = users(:cooperative_admin_user)
    sign_in @user
    @empty = activities(:empty)
    @with_members = activities(:with_members)
  end

  teardown do
    sign_out @user
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should destroy activity" do
  #   assert_difference('Activity.count', -1) do
  #     delete :destroy, id: @activity
  #   end

  #   assert_redirected_to activities_path
  # end

  test "should destroy activity" do
    assert_difference('Activity.count', -1) do
      delete :destroy, id: @empty
    end
  end

  test "should not destroy activity" do
    assert_difference('Activity.count', 0) do
      delete :destroy, id: @with_members
    end
  end

end
