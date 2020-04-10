class EarthlyWeatherStation < ApplicationRecord
    has_many :earthly_readings
    has_many :cities, through: :earthly_readings
end
