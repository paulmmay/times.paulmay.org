class CreateTimesimage < ActiveRecord::Migration
  def self.up
  create_table :timesimages do |t|
  	t.integer :id
  	t.datetime :updated
  	t.string :image_url
  	t.text :image_caption
  	t.string :image_link
  	end
  	add_index :timesimages, :id
  end

  def self.down
  drop_table :timesimages
  end
end
