require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "returns correct cooperative creation roles" do
    assert User.cooperative_roles == %w[cooperative_admin foreman]
  end

  test "user creation defaults to no_role" do
    user=User.create(:email=>'email@email.com',:password=>'password')
    assert_not user.role.eql? :no_role
  end

  test "can't create user with unvalid role" do
    user=User.create(:email=>'email@email.com',:password=>'password', :role => "something")
    assert_not user.save
  end

  test "can create user with valid role" do
    user=User.create(:email=>'email@email.com',:password=>'password', :role => "foreman")
    assert user.save
  end

  test "user creation must have values" do
    user=User.create
    assert_not user.save
  end

  test "user role check" do
  	user=User.create!(:email=>'email1@email.com',:password=>'password', :role=>'admin')
		role_test(user)
		user.role = "cooperative_admin"
		role_test(user)
		user.role = "foreman"
		role_test(user)
		user.role = "no_role"
		role_test(user)
  end

  def role_test user
  	user_role = user.role
		User::ROLES.each do |role|
			if role.eql? user_role
				assert user.is? role
			else
				assert_not user.is? role
			end
		end
  end
end
