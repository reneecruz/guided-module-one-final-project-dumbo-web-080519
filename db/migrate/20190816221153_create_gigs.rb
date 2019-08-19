class CreateGigs < ActiveRecord::Migration[5.0]
  def change
    create_table :gigs do |t|
      t.integer :musician_id
      t.integer :venue_id 
      t.string :name 
      t.string :description 
      t.integer :price
      t.datetime :database
      
      t.timestamps
    end
  end
end
