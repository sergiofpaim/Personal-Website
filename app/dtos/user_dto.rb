class UserDto
  def self.from_entity(user)
    {
      id: user.id,
      nickname: user.nickname,
      picture: user.picture,
      role: user.role,
      posts: user.posts.map do |post|
        {
          id: post.id,
          title: post.title,
          content: post.content
        }
      end
    }
  end

  def self.from_collection(users)
    users.map { |user| from_entity(user) }
  end
end
