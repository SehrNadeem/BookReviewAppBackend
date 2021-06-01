class UsersController < ApplicationController
	skip_before_action :authorized, only: [:create]

	def index
        @users = User.all

        render json: @users
    end
    

   def profile
     @user = User.find(params[:id])
     render json: {user: current_user}
   end

   def create
     @user = User.new(user_params)
     if @user.valid?
         @user.save
         @token = encode_token(@user)
         render json: { user: @user, jwt: @token }
     else
         render json: { error: 'failed to create user' }, status: :not_acceptable
     end
   end

   private

   def user_params
   	params.require(:user).permit(:username, :password, :first_name, :last_name)
   end

end
