class CooperativesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :ensure_cooperative_admin?
	before_filter :ensure_cooperative, except: [:create, :new]

	def create
		@cooperative = Cooperative.new(cooperative_params)
		@cooperative.users << current_user

		if @cooperative.save
			redirect_to cooperative_admin_path(@cooperative)
		else
			render 'new'
		end
	end

	def new
		@cooperative = Cooperative.new
	end

	def edit
		@cooperative = Cooperative.find(current_user.cooperative_id)
	end

	def update
		@cooperative = Cooperative.find(current_user.cooperative_id)

		current_activities = @cooperative.activities.split(", ")
		current_activities << params[:cooperative][:activities]
		format_activities = current_activities.join(", ")
		merged_params = cooperative_params.merge(:activities => format_activities)
		@cooperative.update(merged_params)
		redirect_to edit_cooperative_path(@cooperative)
	end

	def admin
		@cooperative = Cooperative.find(current_user.cooperative_id)
	end

	def import
		Member.import(params[:file], current_user.cooperative_id)
		redirect_to cooperative_members_path
	end

	def clear
		@cooperative = Cooperative.find(current_user.cooperative_id)
		@cooperative.members.delete_all
		redirect_to cooperative_members_path
	end

	private
		def cooperative_params
			params.require(:cooperative).permit(:name, :activities)
		end
end
