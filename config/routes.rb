Rails.application.routes.draw do
  devise_for :users
  mount API::Base, at: "/"
  resources :questions
  # mount GrapeSwagger::Base?, at: "/documentation"
end
