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

    def get_current_weather_for_a_list_of_city_ids(city_ids)
        # OpenWeather::Current.cities([524901, 703448, 2643743], options)
        OpenWeather::Current.cities(city_ids, options)
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
        OpenWeather::Current.circle_zone(lat, lon, radius, options)
    end

    def create_representation(day_reading)
        day = Day.new
        day_reading_to_json = day_reading.to_json
        day_representation = EarthlyRepresenter.new(day).from_json(day_reading_to_json)
    end
end

