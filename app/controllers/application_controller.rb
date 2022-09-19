class ApplicationController < ActionController::API

  def authenticate_request
    req_api_key = request.headers["HTTP_API_KEY"];
    user = User.find_by(api_key: req_api_key);
    puts request.headers["HTTP_USER_AGENT"]

    if request.headers['REQUEST_PATH'] === "/api/v1/users/service"

      err_code =  [ 401, 403 ];

      if !req_api_key
        render json:{
            message: "Request Terminated",
            reason: "API KEY missing"
        },status: err_code[1]
      elsif !user
        render json:{
          message: "Request Terminated",
          reason: "Incorrect API KEY"
       },status: err_code[0]
      else
        if user.usage <= 4
          user.usage+=1
          user.save
        else
          render json:{
            message: "Request Terminated",
            reason: "Usage limit reached, upgrade to increase limit"
         },status: err_code[1]
        end
      end


    end
  end


end
