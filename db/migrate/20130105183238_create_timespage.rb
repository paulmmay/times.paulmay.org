class CreateTimespage < ActiveRecord::Migration
  def self.up
  	create_table :timespages do |t|
  	t.integer :id
  	t.string :url
  	t.datetime :updated
  	t.text :page_source
  	end
  	add_index :timespages, :id
  end

  def self.down
   drop_table :timespages
  end
end
