class SessionDto
  def self.from_entity(session)
    {
      access_token: session.access_token,
      created_at: session.created_at,
      updated_at: session.updated_at,
      user_id: session.user_id
    }
  end

  def self.from_collection(sessions)
    sessions.map { |session| from_entity(session) }
  end
end
