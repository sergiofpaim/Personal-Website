class PostService
  # Create
  def self.create_post(post_params)
    post = Post.new(post_params)

    if post.valid?
      post.save
      PostDto.from_entity(post)
    else
      post.errors
    end
  end

  def self.create_comment(post_id, comment_params)
      post = Post.includes(comments: :user).find_by(id: post_id)
      return { error: "Post not found" } if post.nil?

      comment = post.add_comment(comment_params)

      if comment.valid? && post.save
        post.reload
        PostDto.from_entity(post)
      else
        { errors: comment.errors.full_messages }
      end
  end

  # Get

  def self.get_all_posts
      posts = Post.all
      PostDto.from_collection(posts)
  end

  def self.get_posts(user_id)
      user = UserService.get_user(user_id)
      return { error: "User not found" } if user.nil?

      post = Post.includes(comments: :user).where(user_id: user_id)
      PostDto.from_collection(post)
  end

  # Put

  # Delete
end
