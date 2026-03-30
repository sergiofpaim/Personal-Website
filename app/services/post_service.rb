class PostService
  def self.create_post(request)
    post = Post.new(request)

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
end
