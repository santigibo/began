class Question < ApplicationRecord
  belongs_to :challenge

  has_many :answers, dependent: :destroy
  has_many :question_completions
  has_many :users, through: :question_completions
end
