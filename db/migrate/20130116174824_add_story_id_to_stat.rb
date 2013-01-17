class AddStoryIdToStat < ActiveRecord::Migration
  def change
    add_column :stats, :story_id, :integer
  end
end
