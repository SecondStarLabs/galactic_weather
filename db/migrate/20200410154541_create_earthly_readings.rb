class CreateEarthlyReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :earthly_readings do |t|
      t.belongs_to :earthly_weather_station, null: false, foreign_key: true
      t.belongs_to :city, null: false, foreign_key: true
      t.decimal :temp,            precision: 10, scale: 6
      t.decimal :feels_like,      precision: 10, scale: 6
      t.decimal :temp_min,        precision: 10, scale: 6
      t.decimal :temp_max,        precision: 10, scale: 6
      t.integer :pressure
      t.decimal :humidity,        precision: 10, scale: 6
      t.decimal :wind_speed,      precision: 10, scale: 6
      t.decimal :wind_deg,        precision: 10, scale: 6
      t.integer :cloud_coverage_all
      t.integer :dt

      t.timestamps
    end
  end
end
