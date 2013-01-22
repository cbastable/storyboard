class AddIndexToStories < ActiveRecord::Migration
 def change
    add_index :stories, :user_id
    add_index :stories, :title
    add_index :stories, :primary_genre_id
    add_index :stories, :secondary_genre_id
    add_index :stories, :tertiary_genre_id
    add_index :stories, :created_at
  end
end