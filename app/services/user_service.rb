class UserService
  def self.createUser(dto)
    user = User.new(dto)

    if user.valid?
      user.save
      user
    else
      user.errors
    end
  end
end
