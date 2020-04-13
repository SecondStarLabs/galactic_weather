json.extract! martian_place, :id, :name, :address, :latitude, :longitude, :created_at, :updated_at
json.url martian_place_url(martian_place, format: :json)
