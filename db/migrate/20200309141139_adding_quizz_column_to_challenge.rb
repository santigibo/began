class AddingQuizzColumnToChallenge < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :is_quizz, :boolean, default: false
  end
end
