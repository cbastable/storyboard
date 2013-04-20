class RemoveUpvotesFromStories < ActiveRecord::Migration
 def up
    remove_column :stories, :upvotes
  end
 
  def down
    add_column :stories, :upvotes, :integer
  end
end
