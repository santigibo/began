class ChangequizzIdcolumntochallengeid < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :quizz_id
    add_reference :questions, :challenge, foreign_key: true
  end
end
