class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :story_id
      t.integer :rating

      t.timestamps
    end
    add_index :comments, :rating
    add_index :comments, [:user_id, :created_at]
  end
end
