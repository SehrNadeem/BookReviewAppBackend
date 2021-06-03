# frozen_string_literal: true

class AuthController < ApplicationController
  skip_before_action :require_login, only: %i[login auto_login]

  def login
    user = User.find_by(username: params[:user][:username])
    if user&.authenticate(params[:user][:password])
      exp = 24.hours.from_now
      payload = { user_id: user.id, exp: exp.to_i }
      token = JwtAuthenticationService.encode_token(payload)
      render json: { user: user, jwt: token, success: "Welcome back, #{user.username}" }
    else
      render json: { failure: 'Log in failed! Username or password invalid!' }
    end
  end

  def auto_login
    if JwtAuthenticationService.session_user
      render json: session_user
    else
      render json: { errors: 'No User Logged In' }
    end
  end

  def user_is_authed
    render json: { message: 'You are authorized' }
  end

end
