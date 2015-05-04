class CooperativesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :ensure_cooperative_created, except: [:create, :new]

	def new
		@cooperative = Cooperative.new
	end

	def create
		@cooperative = Cooperative.new(cooperative_params)
		@cooperative.users << current_user

		if @cooperative.save
			flash[:success] = "Welcome to skånken. Helge vare gösta"
			redirect_to cooperative_members_path(@cooperative)
		else
			render 'new'
		end
	end

	def edit
		@cooperative = Cooperative.find(current_user.cooperative_id)
	end

	def update
		@cooperative = Cooperative.find(current_user.cooperative_id)
		if @cooperative.update(cooperative_params)
			flash[:success] = "Fields were successfully updated. Helge vare gösta"
		else
			flash[:danger] = "Something went wrong. Helge vare gösta"
		end
		redirect_to edit_cooperative_path(@cooperative)
	end

	def admin
		@cooperative = Cooperative.find(current_user.cooperative_id)
	end

	def import
		if !params[:file].nil? && params[:file].original_filename.end_with?(".csv")
			Member.import(params[:file], current_user.cooperative_id)
			flash[:success] = "File uploaded. Helge vare gösta"
			redirect_to cooperative_members_path
		else
			flash[:danger] = "No file or wrong file format. Helge vare gösta"
			redirect_to cooperative_admin_path
		end
	end

	def clear
		@cooperative = Cooperative.find(current_user.cooperative_id)
		@cooperative.members.delete_all
		flash[:success] = "All workers deleted. Helge vare gösta"
		redirect_to cooperative_members_path
	end

	private
		def cooperative_params
			params.require(:cooperative).permit(:name, :activities)
		end
end
