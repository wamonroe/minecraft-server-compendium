class ServersController < ApplicationController
  before_action :set_server, only: %i[show edit update destroy]

  decorates_assigned :servers, :server

  # GET /servers
  # GET /servers.json
  def index
    @servers = Server.all
  end

  # GET /servers/1
  # GET /servers/1.json
  def show; end

  # GET /servers/new
  def new
    @server = Server.new
  end

  # GET /servers/1/edit
  def edit; end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(permitted_params.merge(user_id: current_user.id))

    if @server.save
      redirect_to (@referrer_path || @server), notice: 'Server was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /servers/1
  # PATCH/PUT /servers/1.json
  def update
    if @server.update(permitted_params)
      redirect_to (@referrer_path || @server), notice: 'Server was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server.destroy
    redirect_to (@referrer_path || servers_path), notice: 'Server was successfully destroyed.'
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_server
    @server = Server.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    params.require(:server).permit(:name, :description, :hostname, :port)
  end
end
