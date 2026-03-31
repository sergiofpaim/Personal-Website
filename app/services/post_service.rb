class PostService
  # Create
  def self.create_post(post_params)
    post = Post.new(post_params)

    post.save!

    PostDto.from_entity(post)
  end

  def self.create_comment(post_id, comment_params)
    post = Post.find_by(id: post_id)
    return { error: "Post not found" } if post.nil?

    post.add_comment(comment_params)

    post.save!

    PostDto.from_entity(post)
  end

  # Get
  def self.get_all_posts
      posts = Post.all

      PostDto.from_collection(posts)
  end

  def self.get_post_by_id(post_id)
    post = Post.find_by(id: post_id)

    PostDto.from_entity(post)
  end

  def self.get_posts(user_id)
      user = UserService.get_user(user_id)
      return { error: "User not found" } if user.nil?

      posts = Post.where(user_id: user_id)

      PostDto.from_collection(posts)
  end

  # Put
  def self.edit_post(post_id, post_params)
    post = Post.find_by(id: post_id)
    return { erro: "Post not found" } if post.nil?

    post.update!(
      tag: post_params[:tag],
      title: post_params[:title],
      overview: post_params[:overview],
      content: post_params[:content]
    )
    
    PostDto.from_entity(post)
  end

  # Delete
  def self.delete_post(post_id)
    post = Post.find_by(id: post_id)

    post.destroy!
  end
  
  def self.delete_comment(post_id, comment_id)
    post = Post.find_by(id: post_id)
    return { erro: "Post not found" } if post.nil?

    comment = post.comments.find_by(id: comment_id)
    return { erro: "Comment not found in post" } if comment.nil?

    post.remove_comment(comment_id)

    post.save!

    PostDto.from_entity(post)
  end
end
