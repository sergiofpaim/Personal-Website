class UserDto
  def self.from_entity(user)
    {
      id: user.id,
      nickname: user.nickname,
      picture: user.picture,
      role: user.role,
      created_at: user.created_at
    }
  end

  def self.from_collection(users)
    users.map { |user| from_entity(user) }
  end
end
