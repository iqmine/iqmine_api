Rails.application.routes.draw do
  devise_for :users
  mount API::Base, at: "/"
  # mount GrapeSwagger::Base?, at: "/documentation"
end
