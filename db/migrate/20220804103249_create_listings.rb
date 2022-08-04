class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.integer :guests
      t.integer :bedrooms
      t.integer :bathrooms
      t.string :city
      t.string :country
      t.string :street
      t.string :apt_number
      t.text :description
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
