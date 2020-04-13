class AddSolToMartianReading < ActiveRecord::Migration[6.0]
  def change
    add_column :martian_readings, :sol, :integer
  end
end
