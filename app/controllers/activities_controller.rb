class ActivitiesController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_cooperative
  before_filter :ensure_cooperative_admin
  before_filter :set_activity, only: [:edit, :update, :deactivate, :destroy]
  before_filter :ensure_no_members, only: [:destroy]

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    ap = activity_params.merge(cooperative_id: @cooperative.id)
    @activity = Activity.new(ap)
    respond_to do |format|
      if @activity.save
        format.html { redirect_to edit_cooperative_path(@cooperative), notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to edit_cooperative_path(@cooperative), notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def deactivate
    @activity.activated = @activity.activated ? false : true
    @activity.save
    redirect_to edit_cooperative_path(@cooperative)
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to edit_cooperative_path(@cooperative), notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def ensure_no_members
    return true if @activity.members.empty?
    render nothing: true, status: 403
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    id = params[:id] || params[:activity_id]
    @activity = @cooperative.activities.find_by_id(id)
    record_exists?(@activity, 403)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    params.require(:activity).permit(:name).each_value {|name| name.downcase}
  end
end
