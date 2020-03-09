class QuestionCompletionsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    @questions = question.challenge.questions
    QuestionCompletion.create(user: current_user, question: question)
  end
end
