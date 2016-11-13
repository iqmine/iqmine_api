class UserRewards < ActiveRecord::Base
  belongs_to :user
  belongs_to :rewards
end
