class City < ApplicationRecord

    def find_country_code
        c = Country.find_by_name(self.country)
        c.last["alpha2"]
    end

    def get_current_weather
        country_code = self.find_country_code 
        
    end
end
