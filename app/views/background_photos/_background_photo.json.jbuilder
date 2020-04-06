json.extract! background_photo, :id, :name, :source_url, :created_at, :updated_at
json.url background_photo_url(background_photo, format: :json)
