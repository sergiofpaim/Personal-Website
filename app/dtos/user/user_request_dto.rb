class UserRequestDTO
  attr_reader :nickname, :password, :picture, :role

  def initialize(params)
    @nickname = params[:nickname]
    @password = params[:password]
    @picture = params[:picture]
    @role = params[:role]
  end
end
