class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id]) 
    @posts = @user.posts.order(:created_at).reverse
  end
end
