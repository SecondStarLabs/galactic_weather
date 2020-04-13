class CreateMartianWeatherStations < ActiveRecord::Migration[6.0]
  def change
    create_table :martian_weather_stations do |t|
      t.string :name
      t.decimal :latitude,  precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
