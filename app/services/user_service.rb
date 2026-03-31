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
end
