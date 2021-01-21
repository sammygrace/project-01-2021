class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps
    end
    add_index :messages, :conversation_id
    add_index :messages, :user_id
  end
end
