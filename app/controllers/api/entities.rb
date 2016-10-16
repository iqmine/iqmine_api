module API
  module Entities

   

    class User < Grape::Entity
      expose :id
      expose :email
      expose :name
      expose :age
      expose :mobile
      expose :authentication_token, :as=>:access_token
    end

  end
end