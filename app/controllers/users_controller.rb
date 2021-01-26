class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id]) 
    @posts = @user.posts.order(:created_at).reverse
    @friendship = current_user.friendships_as_user.find_by(friend: @user) || current_user.friendships_as_friend.find_by(user: @user)
    @friends = @user.friends + @user.users
    @friend_posts = Post.where(user: @friends).order(:created_at).reverse
  end
end
