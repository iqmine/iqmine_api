module API
  module V1
    module Helpers
      module SignupLoginHelpers
        def user_response_json(user, status="", message="")
          { user: { id: user.id, email: user.email, access_token: user.authentication_token},
                    sign_in_count: user.sign_in_count,
                    status: status, message: message
          }
        end

        def sign_in_count_increment(user)
          user.sign_in_count = user.sign_in_count.to_i + 1
          user.current_sign_in_ip = env["REMOTE_ADDR"].to_s
          user.current_sign_in_at = DateTime.now
          user.save(validate: false)
        end

        def last_sign_in_at_update(user)
          user.last_sign_in_ip = user.current_sign_in_ip
          user.last_sign_in_at = user.current_sign_in_at
          user.authentication_token = nil
          user.save
        end

      end
    end
  end
end