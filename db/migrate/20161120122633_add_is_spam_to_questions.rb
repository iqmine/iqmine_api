class AddIsSpamToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :is_spam, :boolean, :default => false
  end
end
