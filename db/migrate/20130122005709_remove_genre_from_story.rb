class RemoveGenreFromStory < ActiveRecord::Migration
  def self.up
    remove_index :stories, [:user_id, :title, :genre, :created_at]
    remove_column :stories, :genre
  end

  def self.down
    add_column :stories, :genre, :string
  end
end