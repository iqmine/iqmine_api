module API
  module V1
    module Helpers
      module SignupLoginHelpers
        def user_response_json(user, status="", message="")
          pimage = user.user_profile ? user.user_profile.profile_image_public_id  : ""

          { user: { id: user.id, email: user.email, access_token: user.authentication_token, step: user.step,
            social_id: user.social_id, channel_name: user.channel_name, start_time: user.start_time,
            end_time: user.end_time, first_name: user.first_name, last_name: user.last_name,
            pimage: pimage, provider: user.provider, phone_number: user.phone_number,
            sign_in_count: user.sign_in_count, full_address: user.full_address,
            estimated_annual_income: user.estimated_annual_income, social_security_number: user.social_security_number},
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