class LikesController < ApplicationController
  include Pagy::Backend

  load_and_authorize_resource
  before_action :set_like, only: [:show, :destroy]

  # GET /likes
  # GET /likes.json
  def index
    @user = User.find_by(id: params[:user_id])
    @likes = @user.likes.order(:created_at).reverse_order
    @pagy, @likes = pagy(@likes, items: 10)
  end

  def show
  end

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_url(@like.post.user, @like.post) }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to user_post_path(@like.post.user, @like.post), alert: 'Already liked this post.' }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to user_post_path(@like.post.user, @like.post), notice: 'Unliked this post.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
