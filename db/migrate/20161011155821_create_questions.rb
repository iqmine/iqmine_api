class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.boolean :is_open
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
