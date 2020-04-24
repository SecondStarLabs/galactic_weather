class EarthlyReading < ApplicationRecord
  belongs_to :earthly_weather_station
  belongs_to :city

  def collect_all_current_readings
    collected_open_weather_ids  = EarthlyWeatherStation.all
                                  .collect {|earthly_weather_station|  earthly_weather_station.open_weather_id }
    current_readings            = WeatherEarthly.new
                                  .get_current_weather_for_a_list_of_open_weather_ids(collected_open_weather_ids)
    representations             = current_readings.fetch("list")
                                  .collect {|current_reading| we.create_representation(current_reading)}

  end

  def save_all_current_readings
      
  end
end
