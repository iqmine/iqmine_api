Rails.application.routes.draw do
  mount API::Base, at: "/"
  # mount GrapeSwagger::Base?, at: "/documentation"
end
