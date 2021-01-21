class AddFriendIdToConversation < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations, :friend_id, :integer
    add_index :conversations, :friend_id
  end
end
