class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.boolean :choice

      t.timestamps
    end
    add_index :likes, :user_id
  end
end
