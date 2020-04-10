class EarthlyCityGeoCollection
    attr_reader :lat, :lon, :radius
    def initialize(lat: 37.8, lon: -122.27, radius: 10)
        @lat    = lat
        @lon    = lon
        @radius = radius
    end
    # locs = we.get_current_weather_for_cities_around_a_point(lat, lon, radius)

    def discover_city_info
        we                  = WeatherEarthly.new
        current_readings    = we.get_current_weather_for_cities_around_a_point(lat, lon, radius)
        representations     = current_readings.fetch("list")
                                .collect {|current_reading| we.create_representation(current_reading)}
    end

    def get_first_weather_station_in_listed_radius
        station_collection = discover_city_info
        first_city         = station_collection.first
    end
end
