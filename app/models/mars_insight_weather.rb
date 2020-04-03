class MarsInsightWeather
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
        # @response = Representation.new(@response)
    end

    def return_insight_readings
        @response   = self.galactic_client.insight_weather
        @response.parsed_response
        # @response = Representation.new(@response)
    end

    def return_msl_readings
        @response   = self.galactic_client.msl_marsweather.parsed_response
        @response   = @response.fetch("soles", 'invailid_response')
        # @response   = @response.parsed_response
        # @response = Representation.new(@response)
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
            wind_speed_hash = insight_reading_data.fetch("WD").fetch("most_common")
            insight_reading_data.delete("WD")
            # add atomospheric readings as an OpenStruct, Sol, after converting from the current hash
            sol_obj = JSON.parse(insight_reading_data.to_json, object_class: Sol)
            pp "sol_obj are #{sol_obj} "

            # add data sets to sol_representation
            sol_representation.temperatures = sol_obj.AT
            sol_representation.pressure    = sol_obj.PRE
            sol_representation.wind_speed   = Sol.new(wind_speed_hash)

            # clean up poorly named attributes from the API
            sol_representation.first_utc    = sol_representation.First_UTC
            sol_representation.last_utc     = sol_representation.Last_UTC
            sol_representation.season       = sol_representation.Season
            
            sol_representation.delete_field(:First_UTC)
            sol_representation.delete_field(:Last_UTC)
            sol_representation.delete_field(:Season)


            sols_collection << sol_representation
        end
        sols_collection
    end

    def convert_msl_readings_into_collection_of_sols
        msl_readings = self.return_msl_readings
        sols_collection = Array.new
        msl_readings.each do |msl_reading|
            sol = Sol.new
            msl_reading_to_json = msl_reading.to_json
            sol_representation = MslSolRepresenter.new(sol).from_json(msl_reading_to_json)
            sols_collection << sol_representation
        end
        sols_collection
    end


end