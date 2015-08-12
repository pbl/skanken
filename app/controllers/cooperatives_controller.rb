class CooperativesController < ApplicationController
	prepend_before_filter :authenticate_user!
	before_filter :ensure_cooperative_admin
	before_action :set_cooperative

	def edit
		@activities = @cooperative.activities.order(activated: :desc)
	end

	def update
		if @cooperative.update(cooperative_params)
			redirect_to edit_cooperative_path(@cooperative)
		else
			render nothing: true, status: 401
		end
	end

	def import
		if !params[:file].nil? && params[:file].original_filename.end_with?(".csv")
			Member.import(params[:file], current_user.cooperative_id)
			flash[:success] = "File uploaded. Helge vare gösta"
			redirect_to table_table_path
		else
			flash[:danger] = "No file or wrong file format. Helge vare gösta"
			redirect_to cooperative_admin_path
		end
	end

	private
	def cooperative_params
		params.require(:cooperative).permit(:name)
	end
end
