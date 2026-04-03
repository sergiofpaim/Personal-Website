class AuthService
  # Create
  def register(params)
    user = User.find_by(nickname: params[:nickname])
    return { error: "There is a user with this nickname in our system already" } if user

    params[:role] = "user"
    UserService.new.create_user(params)
  end

  # Get
  def login(params)
    user = User.find_by(nickname: params[:nickname], password: params[:password])
    return { error: "Invalid credentials" } if user.nil?

    token = Utils::JwtService.encode(user)

    session = Session.new(user: user, access_token: token)

    session.save!

    session
  end

  # Delete
  def destroy_session(token)
    session = Session.find_by(access_token: token)

    return { error: "Sessão não encontrada" } if session.nil?

    session.destroy
  end
end
