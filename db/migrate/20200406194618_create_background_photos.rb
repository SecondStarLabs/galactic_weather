class CreateBackgroundPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :background_photos do |t|
      t.string :name
      t.text :source_url

      t.timestamps
    end
  end
end
