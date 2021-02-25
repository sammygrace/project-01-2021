module PostsHelper
  def partial_for_liking(post)
    if current_user.likes.where(post_id: post.id).exists?
      "liked_post"
    else
      "like_post"
    end
  end

  def hidden_if_unliked(post, likes)
    if !likes.where(post: post).exists?
      "display: none"
    end
  end

  def hidden_for_short_lists(resource)
    resource.count <= 10 ? "display: none" : "display: initial"
  end
end
