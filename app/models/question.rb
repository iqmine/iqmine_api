class Question < ApplicationRecord
  # belongs_to :user
  belongs_to :sub_category
  belongs_to :user
end
