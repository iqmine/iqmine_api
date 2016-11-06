class QuestionSerializer < ActiveModel::Serializer

  attributes :id, :title, :description, :is_open, :user_id, :sub_category_id, :created_at, :updated_at
end