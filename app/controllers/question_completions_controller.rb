class QuestionCompletionsController < ApplicationController
  def create
    question = Question.find(answer.question)
    QuestionCompletion.create(user: current_user, question: question)
    redirect_to challenge_questions_path(params[:challenge_id])
  end
end
