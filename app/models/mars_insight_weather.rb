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

    attr_reader :api_key, :routes, :connection


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
    end

    def return_insight_readings
        @response   = self.galactic_client.insight_weather        
    end

    def return_msl_readings
        @response   = self.galactic_client.msl_marsweather        
    end



end