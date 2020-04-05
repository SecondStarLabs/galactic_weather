class EarthlyCityGeoCollection
    attr_reader :lat, :lon, :radius
    def initialize(lat: 37.8, lon: -122.27, radius: 10)
        @lat    = lat
        @lon    = lon
        @radius = radius
    end
    # locs = we.get_current_weather_for_cities_around_a_point(lat, lon, radius)

    def discover_and_save_city_info
        we                  = WeatherEarthly.new
        current_readings    = we.get_current_weather_for_cities_around_a_point(lat, lon, radius)
        representations     = current_readings["list"].collect {|current_reading| pp we.create_representation(current_reading)}
        representations.each do |city_rep|
            city            = City.find_or_initialize_by(open_weather_id: city_rep.id) 
            city.lat        = city_rep.coord.lat
            city.lon        = city_rep.coord.lon
            city.name       = city_rep.name
            city.country    = city_rep.sys.country
            city.save!
        end
    end
end
