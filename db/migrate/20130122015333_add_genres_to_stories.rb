class AddGenresToStories < ActiveRecord::Migration
 def self.up
    add_column :stories, :primary_genre_id, :integer
    add_column :stories, :secondary_genre_id, :integer
    add_column :stories, :tertiary_genre_id, :integer
  end

  def self.down
    remove_column :stories, :primary_genre
    remove_column :stories, :secondary_genre
    remove_column :stories, :tertiary_genre
  end
end