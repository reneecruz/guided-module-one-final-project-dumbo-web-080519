class CreateMusicians < ActiveRecord::Migration
  def change
    create_table :musicians do |t|
      t.string :name 
      t.text :bio
      t.string :website_url
      t.string :instrument

      t.timestamps
    end
  end
end

