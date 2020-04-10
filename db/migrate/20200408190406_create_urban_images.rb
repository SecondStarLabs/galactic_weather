class CreateUrbanImages < ActiveRecord::Migration[6.0]
  def change
    create_table :urban_images do |t|
      t.string :name
      t.belongs_to :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
