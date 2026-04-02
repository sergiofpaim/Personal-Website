class UserService
  # Create
  def self.create_user(create_user_params)
    user = User.new(create_user_params)

    user.save!

    UserDto.from_entity(user)
  end

  # Get
  def self.get_user(user_id)
    user = User.find_by(id: user_id)

    UserDto.from_entity(user)
  end

  def self.get_all_users
    users = User.all

    UserDto.from_collection(users)
  end

  # Put
  def self.update_user(user_id, update_user_params)
    user = User.find_by(id: user_id)

    user.update_self(update_user_params)

    user.save!

    UserDto.from_entity(user)
  end

  # Delete
  def self.delete_user(user_id)
    user = User.find_by(id: user_id)

    dto = UserDto.from_entity(user)

    user.destroy!

    dto
  end
end
