require "grape-swagger"
module API  
  module V1
    class Base < Grape::API
      mount API::V1::Users
      mount API::V1::Sessions
      mount API::V1::Questions
      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true,
        schemes: ["http"]
      )
    end
  end
end  