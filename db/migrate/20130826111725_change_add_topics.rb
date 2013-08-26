class ChangeAddTopics < ActiveRecord::Migration
  def up
  	add_column :timesimages, :article_topics, :string
  end

  def down
  	remove_column :timesimages, :article_topics
  end
end
