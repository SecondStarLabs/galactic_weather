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

    logger.debug "==============  Sol readings ========================"
    logger.debug "#{readings.first} "

    readings.each do |reading|
      #<Sol sol="479", temperatures=#<Sol av=-66.032, ct=22909, mn=-93.751, mx=-7.976>, pressure=#<Sol av=651.143, ct=114322, mn=622.6197, mx=676.6724>, 
      # wind_speed=#<Sol compass_degrees=225.0, compass_point="SW", compass_right=-0.707106781187, compass_up=-0.707106781187, ct=3048>, 
      # first_utc="2020-04-01T09:13:13Z", last_utc="2020-04-02T09:52:46Z", season="summer">
      
      martian_reading =  weather_station.martian_readings.where(sol: reading.sol).first_or_initialize
      # test: if this is a new record,
      # then the reading with a record of the place, weather station and the sol haven't been recorded yet
      if martian_reading.martian_place_id.to_i == 0


            martian_reading.sol                   = reading.sol                   
            martian_reading.temp                  = reading.temp                  
            martian_reading.feels_like            = reading.feels_like            
            martian_reading.temp_min              = reading.temp_min              
            martian_reading.temp_max              = reading.temp_max              
            martian_reading.temp_sample_count     = reading.temp_sample_count    
            martian_reading.wind_speed_av         = reading.wind_speed_av         
            martian_reading.wind_speed_count      = reading.wind_speed_count      
            martian_reading.wind_speed_min        = reading.wind_speed_min        
            martian_reading.wind_speed_max        = reading.wind_speed_max       
            martian_reading.wind_degrees          = reading.wind_degrees         
            martian_reading.wind_compass_point    = reading.wind_compass_point    
            martian_reading.wind_compass_right    = reading.wind_compass_right    
            martian_reading.wind_compass_up       = reading.wind_compass_up       
            martian_reading.wind_direction_count  = reading.wind_direction_count  
            martian_reading.season                = reading.season                
            martian_reading.recorded_on           = reading.recorded_on
            martian_reading.martian_place         = @martian_place

        martian_reading.save
        
      end    
    end
  end
end