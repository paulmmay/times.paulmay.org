class CreateTimes < ActiveRecord::Migration
  def self.up
  	create_table :times_pages do |t|
  	t.integer :id
  	t.string :url
  	t.datetime :updated
  	t.text :page_source
  	end
  	add_index :times_pages, :id
  end

  def self.down
  drop_table :times_pages
  end
end