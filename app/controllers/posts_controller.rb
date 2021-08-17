class PostsController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @likes = @user.likes
    @posts = Post.all
    @post = @user.posts.new
    @pagy, @posts = pagy(@posts.order(:created_at).reverse_order, items: 10)
  end

  def my_posts
    @user = current_user
    @posts = @user.posts
    @pagy, @posts = pagy(@posts.order(:created_at).reverse_order, items: 10)
  end

  def show
    @likes = @post.likes
  end

  def new
    @post = current_user.posts.new
    @user = @post.user
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }

        if !request.url.include?("my-posts")
          ActionCable.server.broadcast("post_channel", {
            title: @post.title,
            content: @post.content,
            id: @post.id,
            user_name: User.find_by(id: @post.user_id).name,
            user_id: @post.user_id,
            likes: @post.likes.count,
            created_at: @post.created_at
          })
        end

      else
        format.html { redirect_to posts_path, notice: "Sorry, post could not be created." }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_url(@post.user, @post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { redirect_to edit_user_post_path(@post.user, @post) }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to "/my-posts", notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
      @user = @post.user
    end

    def post_params
      params.require(:post).permit(:title, :user_id, :content)
    end
end
