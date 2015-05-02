class CooperativesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :cooperative_admin?
	before_filter :ensure_cooperative, except: [:create]

	def create
		@cooperative = Cooperative.new(cooperative_params)

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
		redirect_to cooperative_members_path(@cooperative)
	end

	def admin
		@cooperative = Cooperative.find(params[:id])
	end

	def import
		Member.import(params[:file])
	  # redirect_to root_url, notice: "Products imported."
		redirect_to admin_path
	end


	private
    def cooperative_params
      params.require(:cooperative).permit(:name)
    end
end
