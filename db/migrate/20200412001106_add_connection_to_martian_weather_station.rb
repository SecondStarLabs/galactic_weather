class AddConnectionToMartianWeatherStation < ActiveRecord::Migration[6.0]
  def change
    add_column :martian_weather_stations, :data_connection, :string
  end
end
