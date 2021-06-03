class JwtAuthenticationService

  def self.encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.jwt_key)
  end

  def auth_header
    request.headers['Authorization']
  end

  def self.decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        []
      end
    end
  end

  def self.session_user
    decoded_hash = decoded_token
    unless decoded_hash.empty?
      puts decoded_hash.class
      user_id = decoded_hash[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def self.logged_in?
    !!session_user
  end

end