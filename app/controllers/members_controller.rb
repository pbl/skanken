class MembersController < ApplicationController
	prepend_before_filter :authenticate_user!, :set_cooperative
	before_filter :set_member, only: [:show, :edit, :update, :destroy]
	before_filter :get_activities_from_param, only: [:create, :update]
	before_action :set_cooperative_activities, only: [:new, :create, :edit, :update]

	def create
		@member = @cooperative.members.new(member_params)
	  if !@member_activities.empty? && @member.save
	  	@member.activities = @member_activities
		  redirect_to member_path(@member)
		else
			if @member_activities.empty?
				@member.errors.add :activities, t('form.error_no_activity')
			end
			render 'new'
		end
	end

	def new
		@member = @cooperative.members.new
	end

	def show
  end

  def edit
	end


	def update
		if !@member_activities.empty? && @member.update(member_params)
			@member.activities.delete_all
	  	@member.activities = @member_activities
		  redirect_to member_path(@member)
		else
			if @member_activities.empty?
				@member.errors.add :activities, t('form.error_no_activity')
			end
			render 'edit'
		end
	end

	def destroy
	  @member.destroy
		redirect_to table_table_path
	end

	private

	def set_member
		@member = @cooperative.members.find_by_id(params[:id])
		return true unless @member.nil?
		render nothing: true, status: 401
	end

	def set_cooperative_activities
		@activities = @cooperative.activities
	end

	def get_activities_from_param
		activities_id = params[:member].try(:[], 'activities')
		activities_id = activities_id.nil? ? [] : activities_id
		activities_id = activities_id.reject {|id| id.empty?}
		@member_activities = Array.new
		activities_id.each do |id|
			@member_activities << @cooperative.activities.find_by_id(id)
		end
		bad_params = @member_activities.any? {|activity| !activity.is_a?(ActiveRecord::Base) && current_user.cooperative_id == activity.cooperative_id}
		return true unless bad_params
		render nothing: true, status: 401
	end

  def member_params
    params.require(:member).permit(:name, :mobile, :email, :date_of_birth, :comment)
  end
end
