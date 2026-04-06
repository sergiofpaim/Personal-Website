class UserService
  # Create
  def create_user(params)
    user = User.new(params)
    user.save!

    ::ResponseType.success(UserDto.from_entity(user), "User created successfully")
  rescue StandardError => e
    ::ResponseType.error("Error creating user: #{e.message}")
  end

  # Get
  def get_my_profile(user_id)
    user = User.find_by(id: user_id)
    return ::ResponseType.bad_request("User not found") if user.nil?

    ::ResponseType.success(UserDto.from_entity(user), "User profile retrieved successfully")
  rescue StandardError => e
    ::ResponseType.error("Error retrieving user profile: #{e.message}")
  end

  def get_all_user_profiles
    users = User.all

    ::ResponseType.success(UserDto.from_collection(users), "Users retrieved successfully")
  rescue StandardError => e
    ::ResponseType.error("Error retrieving users: #{e.message}")
  end

  def get_user_profile(nickname)
    user = User.find_by(nickname: nickname)
    return ::ResponseType.bad_request("User not found") if user.nil?

    ::ResponseType.success(UserDto.from_entity(user), "User retrieved successfully")
  rescue StandardError => e
    ::ResponseType.error("Error retrieving user: #{e.message}")
  end

  def get_all_users
    users = User.all

    ::ResponseType.success(UserDto.from_collection(users), "Users retrieved successfully")
  rescue StandardError => e
    ::ResponseType.error("Error retrieving users: #{e.message}")
  end

  # Put
  def update_user(user_id, params)
    user = User.find_by(id: user_id)
    return ::ResponseType.bad_request("User not found") if user.nil?

    user.update_self(params)
    user.save!

    ::ResponseType.success(UserDto.from_entity(user), "User updated successfully")
  rescue StandardError => e
    ::ResponseType.error("Error updating user: #{e.message}")
  end

  def set_as_admin(nickname)
    user = User.find_by(nickname: nickname)
    return ::ResponseType.bad_request("User not found") if user.nil?

    user.update_self(role: "admin")
    user.save!

    ::ResponseType.success(UserDto.from_entity(user), "User promoted to admin successfully")
  rescue StandardError => e
    ::ResponseType.error("Error promoting user to admin: #{e.message}")
  end

  # Delete
  def delete_me(user_id)
    user = User.find_by(id: user_id)
    return ::ResponseType.bad_request("User not found") if user.nil?

    dto = UserDto.from_entity(user)
    user.destroy!

    ::ResponseType.success(dto, "User deleted successfully")
  rescue StandardError => e
    ::ResponseType.error("Error deleting user: #{e.message}")
  end

  def delete_user(nickname)
    user = User.find_by(nickname: nickname)
    return ::ResponseType.bad_request("User not found") if user.nil?

    dto = UserDto.from_entity(user)
    user.destroy!

    ::ResponseType.success(dto, "User deleted successfully")
  rescue StandardError => e
    ::ResponseType.error("Error deleting user: #{e.message}")
  end
end
