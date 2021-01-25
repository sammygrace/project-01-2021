class Conversation < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"
  
  belongs_to :friendship

  has_many :messages, dependent: :destroy

  validates :friendship, presence: true
  validates :author, presence: true
  validates :friend, presence: true
end
