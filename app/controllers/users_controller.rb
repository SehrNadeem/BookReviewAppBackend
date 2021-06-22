# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    user = User.create(user_params)

    if user.valid?
      payload = { user_id: user.id }
      token = JsonWebToken.encode(payload)
      render json: { user: user, auth_token: token }
    else
      render json: { errors: user.errors.full_messages }, status: :not_acceptable
    end
  end

  def user_profile
    render json: @current_user
  end

  def index
    users = User.all
    render json: users
  end

  private

  def user_params
    params.permit(:username, :password, :first_name, :last_name, :email)
  end
end
