class ChallengesController < ApplicationController
  def show
    @challenge = Challenge.find(params[:id])
    if @challenge.is_quizz
      @questions = @challenge.questions
    end
  end
end
