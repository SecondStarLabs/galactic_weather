class EarthlyReading < ApplicationRecord
  belongs_to :earthly_weather_station
  belongs_to :city
end
