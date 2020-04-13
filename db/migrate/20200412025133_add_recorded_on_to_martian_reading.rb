class AddRecordedOnToMartianReading < ActiveRecord::Migration[6.0]
  def change
    add_column :martian_readings, :recorded_on, :datetime
  end
end
