class UpdateCityWeatherStationIdPlusLatAndLonJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    # get a listing of the surrounding weather stations for a lat/lon
    # get the data for the first one to rep @city
    # find or create the weather station in the db
    # find or create a the associated weather reading in the db
    # connect the city with the weather station using  that reading with a has_many :through 
    # relationship

    @city = City.find(id)
    ews   = @city.earthly_weather_stations.first_or_create

    if ews.name.to_s.length < 1
      #find and create weather station if it doesn't exist
      ec = EarthlyCityGeoCollection.new(lat: @city.latitude, lon: @city.longitude)
      weather_station = ec.get_first_weather_station_in_listed_radius


      ews.name              = weather_station.name
      ews.country           = weather_station.sys.country
      ews.open_weather_id   = weather_station.id
      # to guard against nil we coerce to float before to decimal
      ews.lat               = weather_station.coord.lat.to_f.to_d
      ews.lon               = weather_station.coord.lon.to_f.to_d
      ews.save
    end

    if @city.earthly_readings.where(dt: weather_station.dt).length == 0
      
      reading = @city.earthly_readings.new(earthly_weather_station: ews)
      reading.temp = weather_station.main.temp.to_d
      reading.feels_like = weather_station.main.feels_like.to_d
      reading.temp_min = weather_station.main.temp_min.to_d
      reading.temp_max = weather_station.main.temp_max.to_d
      reading.pressure = weather_station.main.pressure
      reading.humidity = weather_station.main.humidity.to_d
      reading.wind_speed = weather_station.wind.speed.to_d
      reading.wind_deg = weather_station.wind.deg.to_d
      reading.cloud_coverage_all = weather_station.clouds.all
      reading.dt = weather_station.dt
      reading.recorded_at = Time.at(weather_station.dt)

      # guard for saving an invalid record with nil attributes
      if reading.recorded_at.to_s.length > 0
        reading.save!
      end

      # FIX/REPLACE:  hack to temporarily fix saving record before attributes are set
      # and then saving another record with valid attributes
      @city.earthly_readings.where(recorded_at: nil).delete_all
    end
  end
end
