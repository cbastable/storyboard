class RemoveRatingFromStats < ActiveRecord::Migration
  def up
    remove_column :stats, :rating
    add_column :stories, :upvotes, :integer
  end

  def down
    add_column :stats, :rating, :decimal
    remove_column :stories, :upvotes
  end
end