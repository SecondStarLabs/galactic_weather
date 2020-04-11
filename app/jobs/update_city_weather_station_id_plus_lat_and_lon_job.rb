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
    ec = EarthlyCityGeoCollection.new(lat: @city.latitude, lon: @city.longitude)
    weather_station = ec.get_first_weather_station_in_listed_radius

    ews                   = EarthlyWeatherStation.where(open_weather_id: weather_station.id).first_or_create(name: weather_station.name)
    ews.country           = weather_station.country
    ews.open_weather_id   = weather_station.id
    # to guard against nil we coerce to float before to decimal
    ews.lat               = weather_station.coord.lat.to_f.to_d
    ews.lon               = weather_station.coord.lon.to_f.to_d
    ews.save

    reading = EarthlyReading.where(earthly_weather_station: ews).first_or_initialize

    # test if this is a new record
    if reading.city_id.to_i == 0
      reading.city                        = @city
      reading.temp                        = weather_station.main.temp.to_d
      reading.feels_like                  = weather_station.main.feels_like.to_d
      reading.temp_min                    = weather_station.main.temp_min.to_d
      reading.temp_max                    = weather_station.main.temp_max.to_d
      reading.pressure                    = weather_station.main.pressure
      reading.humidity                    = weather_station.main.humidity.to_d
      reading.wind_speed                  = weather_station.wind.speed.to_d
      reading.wind_deg                    = weather_station.wind.deg.to_d
      reading.cloud_coverage_all          = weather_station.clouds.all
      reading.dt                          = weather_station.dt
      reading.recorded_at                 = Time.at(weather_station.dt)

      reading.save
      
    end
  end
end
