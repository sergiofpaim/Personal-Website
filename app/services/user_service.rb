class UserService
  def self.create_user(params)
    user = User.new(params)

    if user.valid?
      user.save
      user
    else
      user.errors
    end
  end

  def self.get_user(user_id)
    User.find_by(id: user_id)
  end
end
