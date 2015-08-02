class ActivitiesController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :ensure_cooperative_admin
  before_filter :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :set_cooperative

  # GET /activities
  # GET /activities.json
  # def index
  #   @activities = Activity.all
  # end

  # GET /activities/1
  # GET /activities/1.json
  # def show
  # end

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
    ap = activity_params
    ap[:name] = ap[:name].try(:downcase)
    ap = ap.merge(cooperative_id: @cooperative.id)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name)
    end
end
