class AddMartianPlaceToMartianReading < ActiveRecord::Migration[6.0]
  def change
    add_reference :martian_readings, :martian_place, null: false, foreign_key: true
  end
end
