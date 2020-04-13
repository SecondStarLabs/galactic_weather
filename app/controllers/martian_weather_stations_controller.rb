class MartianWeatherStationsController < ApplicationController
  before_action :set_martian_weather_station, only: [:show, :edit, :update, :destroy]

  # GET /martian_weather_stations
  # GET /martian_weather_stations.json
  def index
    @martian_weather_stations = MartianWeatherStation.all
  end

  # GET /martian_weather_stations/1
  # GET /martian_weather_stations/1.json
  def show
  end

  # GET /martian_weather_stations/new
  def new
    @martian_weather_station = MartianWeatherStation.new
  end

  # GET /martian_weather_stations/1/edit
  def edit
  end

  # POST /martian_weather_stations
  # POST /martian_weather_stations.json
  def create
    @martian_weather_station = MartianWeatherStation.new(martian_weather_station_params)

    respond_to do |format|
      if @martian_weather_station.save
        format.html { redirect_to @martian_weather_station, notice: 'Martian weather station was successfully created.' }
        format.json { render :show, status: :created, location: @martian_weather_station }
      else
        format.html { render :new }
        format.json { render json: @martian_weather_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /martian_weather_stations/1
  # PATCH/PUT /martian_weather_stations/1.json
  def update
    respond_to do |format|
      if @martian_weather_station.update(martian_weather_station_params)
        format.html { redirect_to @martian_weather_station, notice: 'Martian weather station was successfully updated.' }
        format.json { render :show, status: :ok, location: @martian_weather_station }
      else
        format.html { render :edit }
        format.json { render json: @martian_weather_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /martian_weather_stations/1
  # DELETE /martian_weather_stations/1.json
  def destroy
    @martian_weather_station.destroy
    respond_to do |format|
      format.html { redirect_to martian_weather_stations_url, notice: 'Martian weather station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_martian_weather_station
      @martian_weather_station = MartianWeatherStation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def martian_weather_station_params
      params.require(:martian_weather_station).permit(:name, :latitude, :latitude, :longitude, :longitude, :data_connection)
    end
end
