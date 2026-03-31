class UserService
  # Create
  def self.create_user(user_params)
    user = User.new(user_params)

    if user.valid?
      user.save
      UserDto.from_entity(user)
    else
      user.errors
    end
  end

  # Get
  def self.get_user(user_id)
    user = User.find_by(id: user_id)
    UserDto.from_entity(user)
  end

  def self.get_all_users()
    users = User.all
    UserDto.from_collection(users)
  end

  # Put
  
  # Delete
end
