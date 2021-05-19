class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :messages 
  has_many :likes

  has_many :friendships_as_user, 
    class_name: "Friendship", foreign_key: :user_id, dependent: :destroy

  has_many :friendships_as_friend, 
    class_name: "Friendship", foreign_key: :friend_id, dependent: :destroy

  has_many :users, through: :friendships_as_friend
  has_many :friends, through: :friendships_as_user

  has_one_attached :photo

  validates :name, uniqueness: { message: "already taken" }
  validates :name, presence: true, allow_blank: false

  validates :photo, presence: true
end
