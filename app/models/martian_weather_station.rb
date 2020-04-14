class MartianWeatherStation < ApplicationRecord
    has_many :martian_readings
    has_many :martian_places, through: :martian_readings
    # has_many :martian_places, through: :martian_readings
end
