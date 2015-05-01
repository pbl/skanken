class CooperativesController < ApplicationController
	before_filter :authenticate_user!

	def new		
	end

	def create
		@cooperative = Cooperative.new(cooperative_params)
		asd
		@cooperative.users << current_user
		if @cooperative.save
			asd
			redirect_to admin_path
		else
			render 'new'
		end
	end

	private
    def cooperative_params
      params.require(:cooperative).permit(:name)
    end
end
