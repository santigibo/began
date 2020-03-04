class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    @challenge = Challenge.find(params[:challenge_id])
  end
end
