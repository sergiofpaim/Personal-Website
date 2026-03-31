class UserService
  # Create
  def self.create_user(user_params)
    user = User.new(user_params)

    if user.valid?
      user.save
      user
    else
      user.errors
    end
  end

  # Get
  def self.get_user(user_id)
    User.find_by(id: user_id)
  end

  # Put
  
  # Delete
end
