json.extract! city, :id, :name, :country, :lat, :lon, :open_weather_id, :created_at, :updated_at
json.url city_url(city, format: :json)
