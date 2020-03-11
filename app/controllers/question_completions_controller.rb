class QuestionCompletionsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    @questions = question.challenge.questions
    the_completion = QuestionCompletion.all.detect { |qc| qc.question == question}
    if the_completion.nil?
      QuestionCompletion.create(user: current_user, question: question)
    end
  end
end
