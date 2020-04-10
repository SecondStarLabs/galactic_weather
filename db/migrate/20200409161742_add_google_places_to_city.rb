class AddGooglePlacesToCity < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :address, :string
    add_column :cities, :latitude, :decimal, precision: 10, scale: 6
    add_column :cities, :longitude, :decimal, precision: 10, scale: 6
  end
end
