require 'test_helper'

class JobTest < ActiveSupport::TestCase
  
  test "should not save job without a activity" do
		job = Job.new
	  assert_not job.save
	end

	test "should save job with a activity" do
		job = Job.new
		job.activity = "A activity"
	  assert job.save
	end
end
