class MartianPlace < ApplicationRecord
    has_many :martian_readings
    has_many :martian_weather_stations, through: :martian_readings

    after_commit        :schedule_update_readings_from_mars_weather_station_job, on: [:create, :update]
    
    def schedule_update_readings_from_mars_weather_station_job
        UpdateReadingsFromMarsWeatherStationJob.perform_later(id)
    end

end
