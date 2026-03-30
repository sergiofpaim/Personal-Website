class PostDto
  def self.from_entity(post)
    {
      id: post.id,
      tag: post.tag,
      title: post.title,
      overview: post.overview,
      content: post.content,
      user_id: post.user_id,
      comments: post.comments.map { |comment| CommentDto.from_entity(comment) },
      created_at: post.created_at,
      updated_at: post.updated_at
    }
  end

  def self.from_collection(posts)
    posts.map { |post| from_entity(post) }
  end
end
