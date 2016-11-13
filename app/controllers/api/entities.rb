module API
  module Entities

   

    class User < Grape::Entity
      expose :id
      expose :email
      expose :name
      expose :age
      expose :mobile
      expose :rewards
      expose :authentication_token, :as=>:access_token
    end

    class Question < Grape::Entity
      expose :id
      expose :title
      expose :description
      expose :is_open
      expose :sub_category_id
      expose :user_id
      expose :is_active
    end

  end
end