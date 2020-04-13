class AddRecordedOnToMartianPlace < ActiveRecord::Migration[6.0]
  def change
    add_column :martian_places, :recorded_on, :datetime
  end
end
