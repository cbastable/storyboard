class AddCurrenciesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :community_points, :integer, default: 0
    add_column :users, :storyboard_points, :integer, default: 0
  end
end