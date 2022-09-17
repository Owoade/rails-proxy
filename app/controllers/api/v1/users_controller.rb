class Api::V1::UsersController < ApplicationController
  def index
    render json: {message: "Welcome to my first rails api"}
  end

  def create
    email = params[:email];
    password = params[:password];
    api_key = SecureRandom.uuid
    usage = 0

    new_user = User.new(email: email, password: password, api_key: api_key, usage: usage)
    puts user_params


    if new_user.save

     render json: {
      message: "User succesfully created!!!",
       data: new_user
      }

    else

      render json: {
        message: "User creation failed",
        reason: new_user.errors
      }, status: :unprocessable_entity

    end
  end

  def get
  end

  private
   def user_params
    params.require(:user).permit(:email, :password )
   end
end
