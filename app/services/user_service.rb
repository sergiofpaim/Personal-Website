class UserService
  def self.create_user(dto)
    user = User.new(dto)

    if user.valid?
      user.save
      user
    else
      user.errors
    end
  end
end
