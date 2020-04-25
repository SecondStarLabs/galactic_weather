class City < ApplicationRecord
    has_many_attached   :files
    has_many            :urban_images
    has_many            :earthly_readings
    has_many            :earthly_weather_stations, through: :earthly_readings

    after_commit        :schedule_creation_of_weather_station, on: [:create, :update]

    validates                   :name, presence: true
    validates                   :latitude, presence: true
    validates                   :longitude, presence: true
    validates                   :address, presence: true
    validates_uniqueness_of     :address
    
    def find_country_code
        c = Country.find_by_name(self.country)
        c.last["alpha2"]
    end

    def get_current_weather
        country_code = self.find_country_code 
        
    end

    def collect_daily_readings_of_city(number_of_days)
      readings_grouped_by_days  = self.earthly_readings.group_by_day(series: true) { |u| u.created_at }
      daily_readings            =  readings_grouped_by_days.values.collect {|i| i.last}
      daily_readings            =  daily_readings.last(number_of_days)
    end

    # to avoid circular running of job after commit, WeatherStation should
    # belong_to city
    def schedule_creation_of_weather_station
        UpdateCityWeatherStationIdPlusLatAndLonJob.perform_later(id)
    end

end
