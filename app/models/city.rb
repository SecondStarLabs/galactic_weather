class City < ApplicationRecord
    has_many_attached :files
    has_many :urban_images

    validates :name, presence: true
    # validates :country, presence: true
    # validates :lat, presence: true
    # validates :lon, presence: true
    
    def find_country_code
        c = Country.find_by_name(self.country)
        c.last["alpha2"]
    end

    def get_current_weather
        country_code = self.find_country_code 
        
    end
end
