class AddUpvotesToStories < ActiveRecord::Migration
  def change
    add_column :stories, :upvotes, :integer, default: 0
  end
end
