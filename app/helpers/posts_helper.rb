module PostsHelper
  def partial_for_liking(post)
    if current_user.likes.where(post_id: post.id).exists?
      "liked_post"
    else
      "like_post"
    end
  end
end
