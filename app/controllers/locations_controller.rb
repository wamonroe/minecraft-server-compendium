class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  decorates_assigned :location

  # GET /servers/1
  # GET /servers/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new(server_id: params[:server_id])
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(permitted_create_params.merge(user_id: current_user.id))

    if @location.save
      redirect_to (@referrer_path || @location.server), notice: "Location was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    if @location.update(permitted_update_params)
      redirect_to (@referrer_path || @location.server), notice: "Location was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    redirect_to (@referrer_path || @location.server), notice: "Location was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def permitted_create_params
    params.require(:location).permit(:name, :description, :dimension, :x, :y, :z, :server_id)
  end

  def permitted_update_params
    params.require(:location).permit(:name, :description, :dimension, :x, :y, :z)
  end
end
