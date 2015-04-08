class MembersController < ApplicationController

	before_filter :authenticate_user!	

	def index
    @members = Member.all
  end

	def create
		date = date_today
		term = params[:term]
		activities = add_activities

		if term.nil?
			term = "vt15"
		end

		workerParams = member_params.merge(:dateAdded => date_today, :workCard => "No card", :term => term, :work => activities.to_s)
		
		@member = Member.new(workerParams)
	  @member.save
	  redirect_to members_path
	end

	def show
    @member = Member.find(params[:id])
    # redirect_to members_path
  end

  def edit
	  @member = Member.find(params[:id])
	end


	def update
		@member = Member.find(params[:id])
		@member.update(member_params)
		redirect_to @member
	end

	def destroy
	  @member = Member.find(params[:id])
	  @member.destroy	 
	  redirect_to members_path
	end

	def creators
	end

	def admin	
	end

	def import
		Member.import(params[:file])
	  # redirect_to root_url, notice: "Products imported."
		redirect_to admin_path
	end

	private 
		def add_activities
			activities = Array.new
			# clubs and bars
			add_activity(:work_svartklubben, activities)
			add_activity(:work_heartland, activities)
			add_activity(:work_foxen, activities)
			add_activity(:work_electrified, activities)
			add_activity(:work_pub, activities)

			# cooking and cafe
			add_activity(:work_lunch, activities)
			add_activity(:work_cafe, activities)
			add_activity(:work_cooking_sittning, activities)

			# Others
			add_activity(:work_serving_sittning, activities)
			add_activity(:work_photo, activities)
			add_activity(:work_graphic, activities)
			return activities
		end


	private 
		def add_activity(activity, activities_array)
			if params.has_key?(activity)

				activity_name_unformated = activity.to_s.split('_')[1]
				activity_name_formated = activity_name_unformated.slice(0,1).capitalize + activity_name_unformated.slice(1..-1)
				activities_array.push(activity_name_formated)
			end			
			return activities_array
		end


	private
	  def member_params
	    params.require(:member).permit(:name, :mobile, :email, :personId, :work, :comment, :dateAdded, :term, :workCard)
	  end
end
