class CreateEarthlyReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :earthly_readings do |t|
      t.belongs_to :earthly_weather_station, null: false, foreign_key: true
      t.belongs_to :city, null: false, foreign_key: true
      t.string :temp
      t.string :feels_like
      t.string :temp_min
      t.string :temp_max
      t.string :pressure
      t.string :humidity
      t.string :wind_speed
      t.string :wind_deg
      t.integer :cloud_coverage_all
      t.integer :dt

      t.timestamps
    end
  end
end
