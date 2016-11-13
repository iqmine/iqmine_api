module API
  module V1
    class Questions < Grape::API
      include API::V1::Defaults
      helpers  API::V1::Helpers::AuthenticationHelpers
      helpers do
        def question_params(params)
          ActionController::Parameters.new(params[:question]).permit(:title,:description,:sub_category_id, :user_id,
                                                                     :is_open)
        end
      end

      resource :questions do
        desc "Return all questions"
        get "", root: :questions do
          questions = Question.all
          status 200
          present :questions, questions, with: API::Entities::Question
          present :status, "success"
        end

        desc "Return a question"
        params do
          requires :id, type: String, desc: "ID of the question"
        end

        get ":id", root: "question" do
          question = Question.where(id: permitted_params[:id]).first!
          status 200
          present :questions, question, with: API::Entities::Question
          present :status, "success"
        end

        desc "Add a Question"
        params do
          group :question, type: Hash do
            requires :title, type: String, allow_blank: false, desc: "Question title"
            requires :description, type: String, allow_blank: false, desc: "Description of a question"
            requires :user_id, type: Integer
            requires :sub_category_id, type: Integer
            requires :is_open, type: Boolean
          end
        end

        post "Add a Question" do
          question = Question.new(question_params(params))
          if question.valid? && question.save
            rewards = Rewards.where(:task=>'Question', :action=>"Create").last
            user = question.user
            UserRewards.create(:rewards_id=>rewards.id, :user_id=>user.id)
            question.user.update(:rewards=>user.rewards.to_i + rewards.points)
            status 201
            { status: 'success', message: 'Question added successfully'}
          else
            error!({status: "failure", message: "#{question.errors.first[0].capitalize} #{question.errors.first[1]}" },
                   422)
          end
        end



      end
    end
  end
end