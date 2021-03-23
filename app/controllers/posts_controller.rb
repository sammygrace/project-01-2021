class PostsController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @user = User.find_by(id: params[:user_id])
    @likes = current_user.likes
    @posts = @user.present? ? @user.posts : Post.all
    @pagy, @posts = pagy(@posts.order(:created_at).reverse_order, items: 10)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @likes = @post.likes
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
    @user = @post.user
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(@post.user, @post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to posts_path }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_path(@post.user), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @user = @post.user
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :user_id, :content)
    end
end
