class AddFriendshipIdToConversation < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations, :friendship_id, :integer
  end
end
