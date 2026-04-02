class PostService
  # Create
  def create_post(post_params)
    post = Post.new(post_params)

    post.save!

    PostDto.from_entity(post)
  end

  def create_comment(post_id, comment_params)
    post = Post.find_by(id: post_id)
    return { error: "Post not found" } if post.nil?

    post.add_comment(comment_params)

    post.save!

    PostDto.from_entity(post)
  end

  # Get
  def get_all_posts
      posts = Post.all

      PostDto.from_collection(posts)
  end

  def get_post_by_id(post_id)
    post = Post.find_by(id: post_id)

    PostDto.from_entity(post)
  end

  def get_posts(user_id)
      user = UserService.new.get_user(user_id)
      return { error: "User not found" } if user.nil?

      posts = Post.where(user_id: user_id)

      PostDto.from_collection(posts)
  end

  # Put
  def edit_post(post_id, post_params)
    post = Post.find_by(id: post_id)
    return { erro: "Post not found" } if post.nil?

    post.update_self(post_params)

    post.save!

    PostDto.from_entity(post)
  end

  # Delete
  def delete_post(post_id)
    post = Post.find_by(id: post_id)
    return { erro: "Post not found" } if post.nil?

    dto = PostDto.from_entity(post)

    post.destroy!

    dto
  end

  def delete_comment(post_id, comment_id)
    post = Post.find_by(id: post_id)
    return { erro: "Post not found" } if post.nil?

    comment = post.comments.find_by(id: comment_id)
    return { erro: "Comment not found in post" } if comment.nil?

    post.remove_comment(comment_id)

    post.save!

    PostDto.from_entity(post)
  end
end
