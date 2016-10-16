module API  
  module V1
    class Users < Grape::API
      include API::V1::Defaults
      helpers  API::V1::Helpers::AuthenticationHelpers
      helpers  API::V1::Helpers::SignupLoginHelpers
      helpers do
        def user_params(params)
          ActionController::Parameters.new(params[:user]).permit(:email,:password,:age,:name,:mobile)
        end     
      end

      resource :users do
        desc "Return all users"
        get "", root: :users do
          users = User.all
          status 200
          present :users, users, with: API::Entities::User
          present :status, "success"
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        
        get ":id", root: "user" do
          user = User.where(id: permitted_params[:id]).first!
          status 200
          present :users, user, with: API::Entities::User
          present :status, "success"
        end

         desc "Conventional Signup"
          params do
            group :user, type: Hash do
              requires :email, type: String, allow_blank: false, desc: "User email"
              requires :password, type: String, allow_blank: false, desc: "User Password"
              requires :name, type: String
              requires :age, type: Integer
            end
          end

          post "signup" do
            user = User.new(user_params(params))
            if user.valid? && user.save
              status 201
              { status: 'success', message: 'User saved successfully'}
            else
              error!({status: "failure", message: "#{user.errors.first[0].capitalize} #{user.errors.first[1]}" }, 422)
            end
          end

      end
    end
  end
end  