class AddCurrenciesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :community_points, :integer
    add_column :users, :storyboard_points, :integer
  end
end