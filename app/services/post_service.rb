class PostService
  # Create
  def create_post(params)
    post = Post.new(params)
    post.save!

    ::ResponseType.success(PostDto.from_entity(post), "Post created successfully")
  rescue StandardError => e
    ::ResponseType.error("Error creating post: #{e.message}")
  end

  def create_comment(post_id, params)
    post = Post.find_by(id: post_id)
    return ::ResponseType.bad_request("Post not found") if post.nil?

    post.add_comment(params)
    post.save!

    ::ResponseType.success(PostDto.from_entity(post), "Comment created successfully")
  rescue StandardError => e
    ::ResponseType.error("Error creating comment: #{e.message}")
  end

  # Get
  def get_all_posts
    posts = Post.all

    ::ResponseType.success(PostDto.from_collection(posts), "Posts retrieved successfully")
  rescue StandardError => e
    ::ResponseType.error("Error retrieving posts: #{e.message}")
  end

  def get_post_by_id(post_id)
    post = Post.find_by(id: post_id)
    return ::ResponseType.bad_request("Post not found") if post.nil?

    ::ResponseType.success(PostDto.from_entity(post), "Post retrieved successfully")
  rescue StandardError => e
    ::ResponseType.error("Error retrieving post: #{e.message}")
  end

  def get_posts(user_id)
    user_result = UserService.new.get_my_profile(user_id)
    return user_result unless user_result.success?

    posts = Post.where(user_id: user_id)

    ::ResponseType.success(PostDto.from_collection(posts), "User posts retrieved successfully")
  rescue StandardError => e
    ::ResponseType.error("Error retrieving user posts: #{e.message}")
  end

  # Put
  def edit_post(post_id, params)
    post = Post.find_by(id: post_id)
    return ::ResponseType.bad_request("Post not found") if post.nil?
    return ::ResponseType.forbidden("Post does not belong to user") if post.user_id != params[:user_id]

    post.update_self(params)
    post.save!

    ::ResponseType.success(PostDto.from_entity(post), "Post updated successfully")
  rescue StandardError => e
    ::ResponseType.error("Error updating post: #{e.message}")
  end

  # Delete
  def delete_my_post(post_id, user)
    post = Post.find_by(id: post_id)
    return ::ResponseType.bad_request("Post not found") if post.nil?
    return ::ResponseType.forbidden("Post does not belong to user") if post.user_id != user.id

    dto = PostDto.from_entity(post)
    post.destroy!

    ::ResponseType.success(dto, "Post deleted successfully")
  rescue StandardError => e
    ::ResponseType.error("Error deleting post: #{e.message}")
  end

  def delete_post(post_id)
    post = Post.find_by(id: post_id)
    return ::ResponseType.bad_request("Post not found") if post.nil?

    dto = PostDto.from_entity(post)
    post.destroy!

    ::ResponseType.success(dto, "Post deleted successfully")
  rescue StandardError => e
    ::ResponseType.error("Error deleting post: #{e.message}")
  end

  def delete_my_comment(post_id, comment_id, user)
    post = Post.find_by(id: post_id)
    return ::ResponseType.bad_request("Post not found") if post.nil?

    comment = post.comments.find_by(id: comment_id)
    return ::ResponseType.bad_request("Comment not found in post") if comment.nil?
    return ::ResponseType.forbidden("Comment does not belong to user") if comment.user_id != user.id

    post.remove_comment(comment_id)
    post.save!

    ::ResponseType.success(PostDto.from_entity(post), "Comment deleted successfully")
  rescue StandardError => e
    ::ResponseType.error("Error deleting comment: #{e.message}")
  end

  def delete_comment(post_id, comment_id)
    post = Post.find_by(id: post_id)
    return ::ResponseType.bad_request("Post not found") if post.nil?

    comment = post.comments.find_by(id: comment_id)
    return ::ResponseType.bad_request("Comment not found in post") if comment.nil?

    post.remove_comment(comment_id)
    post.save!

    ::ResponseType.success(PostDto.from_entity(post), "Comment deleted successfully")
  rescue StandardError => e
    ::ResponseType.error("Error deleting comment: #{e.message}")
  end
end
