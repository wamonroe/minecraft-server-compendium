class LocationsController < ApplicationController
  before_action :set_location, only: %i[edit update destroy]

  decorates_assigned :location

  # GET /locations/new
  def new
    @location = Location.new(server_id: params[:server_id])
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params.merge(user_id: current_user.id))

    if @location.save
      redirect_to @location.server, notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    if @location.update(location_params)
      redirect_to @location.server, notice: 'Location was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    redirect_to @location.server, notice: 'Location was successfully destroyed.'
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:name, :description, :dimension, :x, :y, :z, :server_id)
  end
end
