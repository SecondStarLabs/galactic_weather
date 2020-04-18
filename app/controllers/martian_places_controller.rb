class MartianPlacesController < ApplicationController
  before_action :set_martian_place, only: [:show, :edit, :update, :destroy]

  # GET /martian_places
  # GET /martian_places.json
  def index
    @martian_places = MartianPlace.all
  end

  # GET /martian_places/1
  # GET /martian_places/1.json
  def show
    # @latest_seven_readings      = @martian_place.martian_readings.order(:sol).last(7)
    @latest_seven_readings = @martian_place.martian_readings.order(:sol)
                            .select(:sol, 
                                    :temp, 
                                    :temp_min, 
                                    :temp_max, 
                                    :wind_speed_av, 
                                    :wind_degrees, 
                                    :wind_compass_point, 
                                    :season, 
                                    :recorded_on
                            )
                            .last(7)
    @latest_reading             = @latest_seven_readings.last
  end

  # GET /martian_places/new
  def new
    @martian_place = MartianPlace.new
  end

  # GET /martian_places/1/edit
  def edit
  end

  # POST /martian_places
  # POST /martian_places.json
  def create
    @martian_place = MartianPlace.new(martian_place_params)

    respond_to do |format|
      if @martian_place.save
        format.html { redirect_to @martian_place, notice: 'Martian place was successfully created.' }
        format.json { render :show, status: :created, location: @martian_place }
      else
        format.html { render :new }
        format.json { render json: @martian_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /martian_places/1
  # PATCH/PUT /martian_places/1.json
  def update
    respond_to do |format|
      if @martian_place.update(martian_place_params)
        format.html { redirect_to @martian_place, notice: 'Martian place was successfully updated.' }
        format.json { render :show, status: :ok, location: @martian_place }
      else
        format.html { render :edit }
        format.json { render json: @martian_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /martian_places/1
  # DELETE /martian_places/1.json
  def destroy
    @martian_place.destroy
    respond_to do |format|
      format.html { redirect_to martian_places_url, notice: 'Martian place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_martian_place
      @martian_place = MartianPlace.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def martian_place_params
      params.require(:martian_place).permit(:name, :address, :latitude, :longitude)
    end
end
