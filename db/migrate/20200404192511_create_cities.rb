class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :country
      t.float :lat
      t.float :lon
      t.integer :open_weather_id

      t.timestamps
    end
  end
end
