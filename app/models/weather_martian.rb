class WeatherMartian
    # insight station and curiosity rover, respectively
    ROUTES = {
        insight_weather: {
            method: "get",
            path: "/insight_weather/"
        }, 
        msl_marsweather: {
            method: "get",
            path: "/rss/api/json/msl_marsweather"
        }
    }

    attr_reader :api_key, :routes, :connection, :response


    def initialize(api_key: "DEMO_KEY", routes: ROUTES, connection: InSightApiConnection.new)
        @api_key    = api_key
        @routes     = routes
        @connection = connection
    end

    def api_nasa_connection
        @connection = InSightApiConnection.new
    end

    def mars_nasa_connection
        @connection = MarsNasaConnection.new        
    end

    def galactic_client
        connection  = self.connection
        connection.query(api_key: "DEMO_KEY")
        @client     = GalacticClient.new(connection: self.connection, routes: routes)
    end

    def return_default_response
        @response   = self.galactic_client.insight_weather
        @response   = @response.parsed_response
    end

    def return_insight_readings
        @response   = self.galactic_client.insight_weather
        @response.parsed_response
    end

    def return_msl_readings
        @response   = self.galactic_client.msl_marsweather.parsed_response
        @response   = @response.fetch("soles", 'invailid_response')
    end

    def convert_insight_readings_into_collection_of_sols
        insight_readings = self.return_insight_readings
        #clean up collection of readings for easy parsing
        insight_readings.delete("validity_checks")
        insight_readings.delete("sol_keys")
        # focus on the hashes, otherwise you get something like ["472", {"AT"=>{"av"=>-52.902, "ct"=>263818, "mn"=>-94.156, "mx"=>-7.782}]

        sols_collection = Array.new
        insight_readings.each do |insight_reading|
            insight_reading_sol = insight_reading.first
            insight_reading_data = insight_reading[1]
            insight_reading_data["sol"] = insight_reading_sol
            sol = Sol.new            
            insight_reading_to_json = insight_reading_data.to_json
            # pp insight_reading_to_json
            # initiate sol_representation with properties
            sol_representation = SolRepresenter.new(sol).from_json(insight_reading_to_json)
            # extract wind speed and direction
            wind_direction_hash = insight_reading_data.fetch("WD").fetch("most_common")
            insight_reading_data.delete("WD")
            # add atomospheric readings as an OpenStruct, Sol, after converting from the current hash
            sol_obj = JSON.parse(insight_reading_data.to_json, object_class: Sol)
            pp "sol_obj are today #{sol_obj} "

            # add data sets to sol_representation
            sol_representation.temperatures = sol_obj.AT
            sol_representation.pressure     = sol_obj.PRE
            sol_representation.wind_speed   = sol_obj.HWS
            sol_representation.season       = sol_obj.Season
            sol_representation.wind_direction   = Sol.new(wind_direction_hash) 

            # standardize the naming of attributes from the API
            sol_representation.first_utc    = Time.zone.parse(sol_representation.First_UTC).utc
            sol_representation.last_utc     = Time.zone.parse(sol_representation.Last_UTC).utc

            sol_representation.delete_field(:First_UTC)
            sol_representation.delete_field(:Last_UTC)
            sol_representation.delete_field(:Season)


            # standardize the naming of attributes from the API
            # MartianReading attributes setup           Values based on default values, Sol representations, or calculations
            sol_representation.sol                      = sol_representation.sol.to_i
            sol_representation.temp                     = sol_representation.temperatures.av.to_d
            sol_representation.feels_like               = nil
            sol_representation.temp_min                 = sol_representation.temperatures.mn.to_d
            sol_representation.temp_max                 = sol_representation.temperatures.mx.to_d
            sol_representation.temp_sample_count        = sol_representation.temperatures.ct.to_i
            sol_representation.wind_speed_av            = sol_representation.wind_speed.av.to_d
            sol_representation.wind_speed_count         = sol_representation.wind_speed.ct.to_i
            sol_representation.wind_speed_min           = sol_representation.wind_speed.mn.to_d
            sol_representation.wind_speed_max           = sol_representation.wind_speed.mx.to_d
            sol_representation.wind_degrees             = sol_representation.wind_direction.compass_degrees.to_d
            sol_representation.wind_compass_point       = sol_representation.wind_direction.compass_point.to_s
            sol_representation.wind_compass_right       = sol_representation.wind_direction.compass_right.to_d
            sol_representation.wind_compass_up          = sol_representation.wind_direction.compass_right.to_d
            sol_representation.wind_direction_count     = sol_representation.wind_direction.ct.to_i
            sol_representation.season                   = sol_representation.season.to_s
            sol_representation.recorded_on              = sol_representation.last_utc



            sols_collection << sol_representation
        end
        sols_collection
    end

    def convert_msl_readings_into_collection_of_sols
        # => #<Sol id="2590", terrestrial_date="2020-04-08", sol="2727", ls="179", season="Month 6", min_temp="-68", max_temp="-5", pressure="735", pressure_string="Lower", abs_humidity="--", wind_speed="--", wind_direction="--", atmo_opacity="Sunny", sunrise="05:20", sunset="17:20", local_uv_irradiance_index="High", min_gts_temp="-65", max_gts_temp="4">

        # MartianReading id: 7, martian_weather_station_id: 1, temp: -0.5937e2, feels_like: nil, temp_min: nil, temp_max: nil, temp_sample_count: 88778, wind_speed_av: nil, wind_speed_count: nil, wind_speed_min: nil, wind_speed_max: nil, wind_degrees: nil, wind_compass_point: nil, wind_compass_right: nil, wind_compass_up: nil, wind_direction_count: nil, season: nil, first_utc: nil, last_utc: nil, recorded_at: "2020-04-08 13:50:19", created_at: "2020-04-12 01:30:27", updated_at: "2020-04-12 01:30:27", martian_place_id: 1, sol: 485>
        
        msl_readings = self.return_msl_readings
        sols_collection = Array.new
        msl_readings.each do |msl_reading|
            sol = Sol.new
            msl_reading_to_json = msl_reading.to_json
            sol_representation = MslSolRepresenter.new(sol).from_json(msl_reading_to_json)

            rep_min_temp    = sol_representation.min_temp.to_d
            rep_temp_max    = sol_representation.max_temp.to_d
            rand_temp       = rand(rep_min_temp..rep_temp_max)
            # standardize the naming of attributes from the API
            # MartianReading attributes setup           Values based on default values, Sol representations, or calculations
            sol_representation.temp                     = rand_temp
            # sol_representation.feels_like               = nil
            sol_representation.temp_min                 = sol_representation.min_temp.to_d
            sol_representation.temp_max                 = sol_representation.max_temp.to_d
            # sol_representation.temp_sample_count        = nil
            # sol_representation.wind_speed_av            = nil
            # sol_representation.wind_speed_count         = nil
            # sol_representation.wind_speed_min           = nil
            # sol_representation.wind_speed_max           = nil
            # sol_representation.wind_degrees             = nil
            # sol_representation.wind_compass_point       = nil
            # sol_representation.wind_compass_right       = nil
            # sol_representation.wind_compass_up          = nil
            # sol_representation.wind_direction_count     = nil
            sol_representation.recorded_on              = Time.zone.parse(sol_representation.terrestrial_date).utc
            sol_representation.season                   = sol_representation.season.to_s
            sol_representation.sol                      = sol_representation.sol.to_i

            sols_collection << sol_representation
        end
        sols_collection
    end

    def convert_readings_into_sols
        if self.connection.class.to_s == "MarsNasaConnection"
            self.convert_msl_readings_into_collection_of_sols
        else
            self.convert_insight_readings_into_collection_of_sols
        end
    end


end