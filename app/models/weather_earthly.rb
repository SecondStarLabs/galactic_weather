require 'open_weather'

class WeatherEarthly

    attr_reader :api_key, :units

    def initialize(api_key: Rails.application.credentials.open_weather_app_id,
        units: "metric")
        @api_key    = api_key
        @units      = units
    end

    def options
        { units: units, APPID: api_key }
    end

    def get_current_weather_by_city_name(city_name_and_country)
        # ex: OpenWeather::Current.city("Cochin, IN", options)

    end

    def get_current_weather_by_city_id(city_id)
        # OpenWeather::Current.city_id("1273874", options)
        OpenWeather::Current.city_id(city_id.to_s, options)
    end

    def get_current_weather_by_geocode(lat, lon)
        # OpenWeather::Current.geocode(9.94, 76.26 , options)
        OpenWeather::Current.geocode(lat, lon , options)
    end

    def get_current_weather_for_a_list_of_open_weather_ids(open_weather_ids)
        # OpenWeather::Current.cities([524901, 703448, 2643743], options)
        OpenWeather::Current.cities(open_weather_ids, options)
    end

    def get_current_weather_for_a_bounding_box(top_left_lat, top_left_lon,
        bottom_right_lat, bottom_right_lon,
        map_zoom)
        # OpenWeather::Current.rectangle_zone(12, 32, 15, 37, 10, options)
        OpenWeather::Current.rectangle_zone(top_left_lat, top_left_lon,
        bottom_right_lat, bottom_right_lon,
        map_zoom, 
        options)
    end

    def get_current_weather_for_cities_around_a_point(lat, lon, radius)
        # OpenWeather::Current.circle_zone(55.5, 37.5, 10, options)
        OpenWeather::Current.circle_zone(lat.to_s, lon.to_s, radius.to_s, options)
    end

    def create_representation(day_reading)
        day = Day.new
        day_reading_to_json = day_reading.to_json
        day_representation = EarthlyRepresenter.new(day).from_json(day_reading_to_json)
    end

    def collect_all_current_reports
        collected_open_weather_ids  = EarthlyWeatherStation.all
                                    .collect {|earthly_weather_station|  earthly_weather_station.open_weather_id }
        current_readings            = self.get_current_weather_for_a_list_of_open_weather_ids(collected_open_weather_ids)
        representations             = current_readings.fetch("list")
                                    .collect {|current_reading| self.create_representation(current_reading)}

    end

    def collect_and_save_all_latest_reports
        latest_reports = WeatherEarthly.new.collect_all_current_reports

        # collect the pertinent attributes of earthly_readings and group them to avoid dupes
        old_readings = EarthlyReading.select(:id, :city_id, :earthly_weather_station_id).group(:city_id, :earthly_weather_station_id, :id)
        # add the OpenWeather station ID and convert to OpenStruct while we are at it
        improved_readings = old_readings.all.collect {
            |reading| OpenStruct.new(
                {city_id: reading.city_id, 
                    earthly_weather_station_id: reading.earthly_weather_station_id, 
                    open_weather_id: EarthlyWeatherStation.find(reading.earthly_weather_station_id).open_weather_id
                }
            )
        }

        improved_readings.each do |reading|
            # select the matching report for the reading
            latest  = latest_reports.find {|lr| lr.id == reading.open_weather_id}

            city    = City.find(reading.city_id)
            # only record the report if it is later than what is currently recorded
            if latest.dt > city.earthly_readings.last.dt 
                ews     = EarthlyWeatherStation.find(reading.earthly_weather_station_id)

                new_reading = city.earthly_readings.create(earthly_weather_station: ews,
                    temp:                latest.main.temp.to_d,
                    feels_like:          latest.main.feels_like.to_d,
                    temp_min:            latest.main.temp_min.to_d,
                    temp_max:            latest.main.temp_max.to_d,
                    pressure:            latest.main.pressure,
                    humidity:            latest.main.humidity.to_d,
                    wind_speed:          latest.wind.speed.to_d,
                    wind_deg:            latest.wind.deg.to_d,
                    cloud_coverage_all:  latest.clouds.all,
                    dt:                  latest.dt,
                    recorded_at:         Time.at(latest.dt)
                )
            end
        end
    end

end

