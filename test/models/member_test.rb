require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  test "should not save member without name" do
	  member = Member.new
	  member.mobile = "A number"
	  member.activities = "A activity"
	  assert_not member.save
	end

	test "should not save member without mobile" do
		member = Member.new
		member.name = "Name"
		member.activities = "A activity"
	  assert_not member.save
	end

	test "should not save member without a activity" do
		member = Member.new
		member.mobile = "A number"
		member.name = "Name"
	  assert_not member.save
	end

	test "should save member with name, mobile and activities" do
		member = Member.new
		member.mobile = "A number"
		member.name = "Name"
		member.activities = "A activity"
	  assert member.save
	end

end
