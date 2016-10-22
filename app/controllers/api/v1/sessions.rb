module API
  module V1
    class Sessions < Grape::API
      helpers  API::V1::Helpers::SignupLoginHelpers
      resource :sessions do

        desc "Authenticate user and return user object / access token"

          params do
            requires :email, type: String, allow_blank: false, desc: "User email"
            requires :password, type: String, allow_blank: false, desc: "User Password"
          end
          post do
            user = User.where(:email=>params[:email]).first
            if user.nil? || !user.valid_password?(params[:password])
              error_message = "Invalid Email or Password"
              error!({ status: "failure", message: error_message}, 200)
            else
              user.ensure_authentication_token
              sign_in_count_increment(user)
              user_response_json(user, "success", "Login successfully")
            end
          end

        desc "Destroy the access token"
          params do
            requires :access_token, type: String, allow_blank: false, desc: "User Access Token"
          end
          delete ':access_token' do
            access_token = params[:access_token]
            user = User.where(authentication_token: access_token).first
            if user.nil?
              error!({ status: "failure", message: "Invalid access token"}, 200)
            else
              last_sign_in_at_update(user)
              { status: "success", message: "Logout successfully"}
            end
          end
      end
    end
  end
end