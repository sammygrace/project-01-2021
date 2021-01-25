class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  has_one :conversation, dependent: :destroy

  validates :user, presence: true
  validates :friend, presence: true
end
