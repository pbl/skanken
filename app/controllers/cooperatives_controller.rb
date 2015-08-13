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
			import = Import.new(params[:file], current_user.cooperative)
			import.import
			redirect_to table_table_path
		else
			flash[:danger] = t('import.error')
			redirect_to edit_cooperative_path(@cooperative)
		end
	end

	private

	def cooperative_params
		params.require(:cooperative).permit(:name)
	end
end
