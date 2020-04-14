class CreateMartianReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :martian_readings do |t|
      t.belongs_to :martian_weather_station, null: false, foreign_key: true
      t.decimal :temp,                precision: 10, scale: 6
      t.decimal :feels_like,          precision: 10, scale: 6
      t.decimal :temp_min,            precision: 10, scale: 6
      t.decimal :temp_max,            precision: 10, scale: 6
      t.integer :temp_sample_count
      t.decimal :wind_speed_av,       precision: 10, scale: 6
      t.integer :wind_speed_count
      t.decimal :wind_speed_min,      precision: 10, scale: 6
      t.decimal :wind_speed_max,      precision: 10, scale: 6
      t.decimal :wind_degrees,        precision: 10, scale: 6
      t.string :wind_compass_point
      t.decimal :wind_compass_right,  precision: 10, scale: 6
      t.decimal :wind_compass_up,     precision: 10, scale: 6
      t.integer :wind_direction_count
      t.string :season
      t.datetime :first_utc
      t.datetime :last_utc
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
