class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :reader_id
      t.integer :publisher_id

      t.timestamps
    end
    add_index :relationships, :reader_id
    add_index :relationships, :publisher_id
    add_index :relationships, [:reader_id, :publisher_id], unique: true
  end
end
