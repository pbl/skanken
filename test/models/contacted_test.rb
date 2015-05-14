require 'test_helper'

class ContactedTest < ActiveSupport::TestCase
  
  test "should not save contacted without a activity" do
		contacted = Contacted.new
	  assert_not contacted.save
	end

	test "should save contacted with a activity" do
		contacted = Contacted.new
		contacted.activity = "A activity"
	  assert contacted.save
	end
end

