class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :title, presence: { message: "title cannot be blank" }
  validates :user_id, presence: true
end
