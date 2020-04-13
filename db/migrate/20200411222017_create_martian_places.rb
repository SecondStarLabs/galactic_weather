class CreateMartianPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :martian_places do |t|
      t.string :name
      t.string :address
      t.decimal :latitude,  precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
