class ChallengeCompletionsController < ApplicationController
  def create
    challenge = Challenge.find(params[:challenge_id])
    ChallengeCompletion.create(user: current_user, challenge: challenge)
    redirect_to category_path(current_user.category_id)
  end
end
