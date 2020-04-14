class MarsController < ApplicationController
  def index
    @latest_reading = @city.earthly_readings.last
    @latest_seven_readings = @city.earthly_readings.last(7)    
  end
end
