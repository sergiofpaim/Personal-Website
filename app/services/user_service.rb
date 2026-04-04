class UserService
  # TODO: Verificar se o usuário que solicita é o da requisição

  # Create
  def create_user(params)
    user = User.new(params)

    user.save!

    UserDto.from_entity(user)
  end

  # Get
  def get_my_profile(user_id)
    user = User.find_by(id: user_id)
    return { erro: "User not found" } if user.nil?

    UserDto.from_entity(user)
  end

  def get_all_user_profiles
    users = User.all

    UserDto.from_collection(users)
  end

  def get_user_profile(nickname)
    user = User.find_by(nickname: nickname)
    return { erro: "User not found" } if user.nil?

    UserDto.from_entity(user)
  end

  def get_all_users
    users = User.all

    UserDto.from_collection(users)
  end

  # Put
  def update_user(user_id, params)
    user = User.find_by(id: user_id)
    return { erro: "User not found" } if user.nil?

    user.update_self(params)

    user.save!

    UserDto.from_entity(user)
  end

  def set_as_admin(user_id)
    user = User.find_by(id: user_id)
    return { erro: "User not found" } if user.nil?

    user.update_self(role: "admin")

    user.save!

    UserDto.from_entity(user)
  end

  # Delete
  def delete_me(user_id)
    user = User.find_by(id: user_id)
    return { erro: "User not found" } if user.nil?

    dto = UserDto.from_entity(user)

    user.destroy!

    dto
  end

  def delete_user(nickname)
    user = User.find_by(nickname: nickname)
    return { erro: "User not found" } if user.nil?

    dto = UserDto.from_entity(user)

    user.destroy!

    dto
  end
end
