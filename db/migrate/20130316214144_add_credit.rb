class AddCredit < ActiveRecord::Migration
  def up
  	add_column :timesimages, :image_credit, :string
  end

  def down
    remove_column :timesimages, :image_credit
  end
end



