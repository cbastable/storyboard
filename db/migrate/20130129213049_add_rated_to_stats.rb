class AddRatedToStats < ActiveRecord::Migration
  def change
    add_column :stats, :rated, :boolean, default: false
  end
end
