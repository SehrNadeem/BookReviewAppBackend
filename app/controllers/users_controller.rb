# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    user = User.create(user_params)
    if user.valid?
      payload = { user_id: user.id }
      token = JwtAuthenticationService.encode_token(payload)
      puts token
      render json: { user: user, jwt: token }
    else
      render json: { errors: user.errors.full_messages }, status: :not_acceptable
    end
  end

  def user_profile
    render json: @user
  end

  def index
    @users = User.all
    render json: @users
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name)
  end
end
