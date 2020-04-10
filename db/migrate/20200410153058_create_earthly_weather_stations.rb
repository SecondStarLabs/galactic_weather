class CreateEarthlyWeatherStations < ActiveRecord::Migration[6.0]
  def change
    create_table :earthly_weather_stations do |t|
      t.string :name
      t.string :country
      t.integer :open_weather_id
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lon, precision: 10, scale: 6

      t.timestamps
    end
  end
end
