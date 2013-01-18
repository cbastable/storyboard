class CreateBoards < ActiveRecord::Migration
  def change
    drop_table :boards
    create_table :boards do |t|
      t.integer :user_id
      t.integer :story_id
      t.string :name

      t.timestamps
    end
    
    add_index :boards, :user_id
    add_index :boards, :story_id
    add_index :boards, :name
    add_index :boards, [:name, :story_id], unique: true
  end
end