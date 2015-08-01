require 'test_helper'
class CooperativeTest < ActiveSupport::TestCase
	
	test "should not save cooperative without name" do
		cooperative = Cooperative.new
		cooperative.activities = "A activity"
	  assert_not cooperative.save
	end

	test "should not save cooperative without activities" do
		cooperative = Cooperative.new
		cooperative.name = "A activity"
	  assert_not cooperative.save
	end

	test "should save cooperative without name and activities" do
		cooperative = Cooperative.new
		cooperative.name = "Name"
		cooperative.activities = "A activity"
	  assert cooperative.save
	end

	test "activities hash should be formated with same key as value" do
		cooperative = cooperatives(:one)
		hash = Cooperative.activities(cooperative.id)
	  assert_equal hash["Lunch"], "Lunch"
	  assert_equal hash["Svartklubben"], "Svartklubben"
	end

	test "activities hash should have the right size" do
		cooperative = cooperatives(:one)
		hash = Cooperative.activities(cooperative.id)
	  assert hash.size == 2
	end


end
