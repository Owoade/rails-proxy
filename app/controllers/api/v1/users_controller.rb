class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request, only: :service
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

  def auth
    email = params[:email];
    password = params[:password];

    user = User.find_by(email: email)

    if !user
      return render json: {
        message: "Authentication failed",
        reason: "User doesn't exist"
      }, status: 404

    elsif user.password != password
        return render json: {
          message: "Authentication failed",
          reason: "Password incorrect"
        }, status: 401
    else
      return render json: {
        message: "Authentication sucessful",
        data:{
          api_key: user.api_key,
          usage: user.usage
        }
      }, status: 200
    end

  end

  def service
    all_users = User.all.map { |user| user.email }
    return render json: {
      message: "All users",
      data: all_users
    }
  end


  private
   def user_params
    params.require(:user).permit(:email, :password )
   end
end
