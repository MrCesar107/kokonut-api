class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false
      t.string :description
      t.string :status, null: false, default: :active

      t.timestamps
    end
  end
end
