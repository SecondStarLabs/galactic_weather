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

    def collect_all_current_readings
        collected_open_weather_ids  = EarthlyWeatherStation.all
                                    .collect {|earthly_weather_station|  earthly_weather_station.open_weather_id }
        current_readings            = self.get_current_weather_for_a_list_of_open_weather_ids(collected_open_weather_ids)
        representations             = current_readings.fetch("list")
                                    .collect {|current_reading| self.create_representation(current_reading)}

    end

    def save_all_current_readings
        all_current_readings = WeatherEarthly.new.collect_all_current_readings
        all_current_readings.each do |weather_station|
            ews     = EarthlyWeatherStation.find_by!("open_weather_id = ?", weather_station.id)
            city    = ews.cities.first

            reading = city.earthly_readings.new(earthly_weather_station: ews)
            # reading.temp = weather_station.main.temp.to_d
            # reading.feels_like = weather_station.main.feels_like.to_d
            # reading.temp_min = weather_station.main.temp_min.to_d
            # reading.temp_max = weather_station.main.temp_max.to_d
            # reading.pressure = weather_station.main.pressure
            # reading.humidity = weather_station.main.humidity.to_d
            # reading.wind_speed = weather_station.wind.speed.to_d
            # reading.wind_deg = weather_station.wind.deg.to_d
            # reading.cloud_coverage_all = weather_station.clouds.all
            # reading.dt = weather_station.dt
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

