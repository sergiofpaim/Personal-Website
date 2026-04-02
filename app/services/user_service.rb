class UserService
  # TODO: Verificar se o usuário que solicita é o da requisição

  # Create
  def create_user(create_user_params)
    user = User.new(create_user_params)

    user.save!

    UserDto.from_entity(user)
  end

  # Get
  def get_user(user_id)
    user = User.find_by(id: user_id)

    UserDto.from_entity(user)
  end

  def get_all_users
    users = User.all

    UserDto.from_collection(users)
  end

  # Put
  def update_user(user_id, update_user_params)
    user = User.find_by(id: user_id)
    return { erro: "User not found" } if user.nil?

    user.update_self(update_user_params)

    user.save!

    UserDto.from_entity(user)
  end

  # Delete
  def delete_user(user_id)
    user = User.find_by(id: user_id)
    return { erro: "User not found" } if user.nil?

    dto = UserDto.from_entity(user)

    user.destroy!

    dto
  end
end
