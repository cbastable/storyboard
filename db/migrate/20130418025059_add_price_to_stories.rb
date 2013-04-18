class AddPriceToStories < ActiveRecord::Migration
  def change
    add_column :stories, :price, :integer, default: 0
  end
end
