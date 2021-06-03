# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :require_login

  def require_login
    render json: { message: 'Please Login' }, status: :unauthorized unless JwtAuthenticationService.logged_in?
  end
end
