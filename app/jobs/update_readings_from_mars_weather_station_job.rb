class UpdateReadingsFromMarsWeatherStationJob < ApplicationJob
  
  queue_as :default

  def perform(id)
    # Do something later
    # get a listing of the surrounding weather stations for a lat/lon
    # get the data for the first one to rep @city
    # find or create the weather station in the db
    # find or create a the associated weather reading in the db
    # connect the city with the weather station using  that reading with a has_many :through 
    # relationship

    # current connections: InSightApiConnection, and MarsNasaConnection
    @martian_place    = MartianPlace.find(id)
    weather_station   = MartianWeatherStation.where(latitude: @martian_place.latitude).where(longitude: @martian_place.longitude).first
    connection        = weather_station.data_connection.to_s.constantize.new
    wm                = WeatherMartian.new(connection: connection)
    readings          = wm.convert_readings_into_sols

    readings.each do |reading|
      #<Sol sol="479", temperatures=#<Sol av=-66.032, ct=22909, mn=-93.751, mx=-7.976>, pressure=#<Sol av=651.143, ct=114322, mn=622.6197, mx=676.6724>, 
      # wind_speed=#<Sol compass_degrees=225.0, compass_point="SW", compass_right=-0.707106781187, compass_up=-0.707106781187, ct=3048>, 
      # first_utc="2020-04-01T09:13:13Z", last_utc="2020-04-02T09:52:46Z", season="summer">
      
      martian_reading =  weather_station.martian_readings.where(sol: reading.sol).first_or_initialize
      # test if this is a new record. If the martian_place_id.to_i == 0, 
      # then it is null and didn't exist before
      if martian_reading.martian_place_id.to_i == 0

        martian_reading.save
        
      end    
    end
  end
end