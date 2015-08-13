# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 1 cooperative
# 500 members
# 10 activities
# no jobs no contacteds
# admin user and foreman user on the same site


class FakerCreator
  # TIMES_COOPERATIVE = 1
  TIMES_ACTIVITY    = 10
  TIMES_MEMBER      = 500

  def initialize
    # @cooperatives = TIMES_COOPERATIVE
    @activities = TIMES_ACTIVITY
    @members = TIMES_MEMBER
  end

  def seed_demo
    cooperative
  end

  def seed_empty
    cooperative = Cooperative.create(name: 'Skanken')
    users(cooperative)
  end

  private

  def cooperative
    name = Faker::App.name
    cooperative = Cooperative.find_or_create_by!(name: name)
    activities(cooperative)
    users(cooperative)
  end

  def activities(cooperative)
    @activities.times do
      name = Faker::Company.name
      cooperative.activities.find_or_create_by!(name: name)
    end
    members(cooperative)
  end

  def members(cooperative)
    @members.times do
      name = Faker::Name.name
      # mobile = Faker::PhoneNumber.cell_phone
      mobile = 0735005005
      activities = []
      nbr_activities = rand(3)+1
      (1..nbr_activities).each do
        activity_id = rand(cooperative.activities.count)
        activities << cooperative.activities[activity_id]
      end
      activities.uniq!
      member = cooperative.members.find_or_create_by!(name: name, mobile: mobile)
      member.activities = activities
    end
  end

  def users(cooperative)
    cooperative.users.create!({email: 'admin@admin.com', role: :cooperative_admin, password: 'asdfasdf', password_confirmation: 'asdfasdf', cooperative_id: 1 })
    cooperative.users.create!({email: 'user@user.com', role: :foreman, password: 'asdfasdf', password_confirmation: 'asdfasdf', cooperative_id: 1 })
  end
end

seeder = FakerCreator.new
# seeder.seed_demo
seeder.seed_empty

