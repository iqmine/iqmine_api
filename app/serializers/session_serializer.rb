class SessionSerializer < ActiveModel::Serializer

  attributes :id, :name, :age, :mobile, 
       :email, :city, :country, :created_at, :updated_at
end 