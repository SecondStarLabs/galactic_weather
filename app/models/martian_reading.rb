class MartianReading < ApplicationRecord
  belongs_to :martian_weather_station
  belongs_to :martian_place
end
