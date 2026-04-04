class PostService
  # Create
  def create_post(params)
    post = Post.new(params)

    post.save!

    PostDto.from_entity(post)
  end

  def create_comment(post_id, params)
    post = Post.find_by(id: post_id)
    return { error: "Post not found" } if post.nil?

    post.add_comment(params)

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
      user = user_exists(user_id)
      return { error: "User not found" } if user.nil?

      posts = Post.where(user_id: user_id)

      PostDto.from_collection(posts)
  end

  # Put
  def edit_post(post_id, params)
    post = Post.find_by(id: post_id)
    return { erro: "Post not found" } if post.nil?

    return { erro: "Post does not belong to user" } if post.user_id != params[:user_id]

    post.update_self(params)

    post.save!

    PostDto.from_entity(post)
  end

  # Delete
  def delete_my_post(post_id, user)
    post = Post.find_by(id: post_id)
    return { erro: "Post not found" } if post.nil?

    return { erro: "Post does not belong to user" } if post.user_id != user.id

    dto = PostDto.from_entity(post)

    post.destroy!

    dto
  end

  def delete_my_comment(post_id, comment_id, user)
    post = Post.find_by(id: post_id)
    return { erro: "Post not found" } if post.nil?

    comment = post.comments.find_by(id: comment_id)
    return { erro: "Comment not found in post" } if comment.nil?

    return { erro: "Comment does not belong to user" } if comment.user_id != user.id

    post.remove_comment(comment_id)

    post.save!

    PostDto.from_entity(post)
  end

  private

  def user_exists(user_id)
    UserService.new.get_user_profile(user_id)
  end
end
