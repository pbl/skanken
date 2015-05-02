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
		@cooperative.update(cooperative_params)
		redirect_to cooperative_members_path(@cooperative)
	end

	def admin
		@cooperative = Cooperative.find(current_user.cooperative_id)
	end

	def accounts
		@user = User.all
		@cooperative = Cooperative.find(current_user.cooperative_id)
	end

	def import
		Member.import(params[:file], current_user.cooperative_id)
		redirect_to admin_path
	end


	private
    def cooperative_params
      params.require(:cooperative).permit(:name)
    end
end
