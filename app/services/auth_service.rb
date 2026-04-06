class AuthService
  # Create
  def register(params)
    user = User.find_by(nickname: params[:nickname])
    return ::ResponseType.conflict("There is a user with this nickname in our system already") if user

    params[:role] = "user"

    user_result = UserService.new.create_user(params)
    return user_result unless user_result.success?

    ::ResponseType.success(user_result.payload, "User registered successfully")
  rescue StandardError => e
    ::ResponseType.error("Error registering user: #{e.message}")
  end

  # Get
  def login(params)
    user = User.find_by(nickname: params[:nickname], password: params[:password])
    return ::ResponseType.unauthorized("Invalid credentials") if user.nil?

    token = Utils::JwtService.encode(user)
    session = Session.new(user: user, access_token: token)
    session.save!

    ::ResponseType.success(SessionDto.from_entity(session), "Login successful")
  rescue StandardError => e
    ::ResponseType.error("Error logging in: #{e.message}")
  end

  # Delete
  def logout(token)
    session = Session.find_by(access_token: token)
    return ::ResponseType.bad_request("Session not found") if session.nil?

    session.destroy!

    ::ResponseType.success(nil, "Logout successful")
  rescue StandardError => e
    ::ResponseType.error("Error logging out: #{e.message}")
  end
end
