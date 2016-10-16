module API
  module V1
    module Helpers
    module AuthenticationHelpers

      def required_authentication
        unless authenticated
          error!({ status: "failure",message: "Unauthorized"}, 401)
          return
        end
      end

      def permitted_params
        @permitted_params ||= declared(params,
         include_missing: false)
      end

      def logger
        Rails.logger
      end

      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated?
        params[:access_token] && @user = User.find_by_authentication_token(params[:access_token])
      end

      def current_user
        warden.user || @user
      end
    end
  end
  end
end