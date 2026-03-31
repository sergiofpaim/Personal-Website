class PostService
  def self.create_post(params)
    post = Post.new(params)

    if post.valid?
      post.save
      PostDto.from_entity(post)
    else
      post.errors
    end
  end

  def self.get_posts(request = nil)
    if request.nil?
      posts = Post.includes(comments: :user).all
      PostDto.from_collection(posts)
    else
      post = Post.includes(comments: :user).find(request)
      PostDto.from_entity(post)
    end
  end

  def self.create_comment(post_id, params)
      post = Post.includes(comments: :user).find_by(id: post_id)
      return { error: "Post não encontrado" } if post.nil?

      comment = post.add_comment(params)

      if comment.valid? && post.save
        post.reload
        PostDto.from_entity(post)
      else
        { errors: comment.errors.full_messages }
      end
  end
end
