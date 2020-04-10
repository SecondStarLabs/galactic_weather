class AddRecordedAtToEarthlyReading < ActiveRecord::Migration[6.0]
  def change
    add_column :earthly_readings, :recorded_at, :datetime
  end
end
