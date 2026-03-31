class CommentDto
  def self.from_entity(comment)
    {
      id: comment.id,
      content: comment.content,
      user: {
        id: comment.user.id,
        nickname: comment.user.nickname,
        picture: comment.user.picture
      },
      created_at: comment.created_at,
      updated_at: comment.updated_at
    }
  end
end
