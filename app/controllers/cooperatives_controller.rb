class CooperativesController < ApplicationController
	before_filter :authenticate_user!

	def new
		@cooperative = Cooperative.new
	end

	def create
		@cooperative = Cooperative.new(cooperative_params)
		# @cooperative.users << current_user

		if @cooperative.save
			user = User.find(current_user.id)
			user.cooperatives_id = @cooperative.id
			user.save
			redirect_to admin_path
		else
			render 'new'
		end
	end

	def edit
		@cooperative = Cooperative.find(params[:id])
	end

	def update
		@cooperative = Cooperative.find(params[:id])
		@cooperative.update(cooperative_params)
		redirect_to root_path
	end

	private
    def cooperative_params
      params.require(:cooperative).permit(:name)
    end
end
