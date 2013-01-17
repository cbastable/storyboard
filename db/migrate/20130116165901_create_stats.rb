class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :viewer_id
      t.boolean :viewed, default: false
      t.decimal :rating

      t.timestamps
    end
    
    add_index :stats, :viewer_id
    add_index :stats, :viewed
    add_index :stats, :rating
    add_index :stats, [:viewer_id, :viewed, :rating], unique: true
  end
end
