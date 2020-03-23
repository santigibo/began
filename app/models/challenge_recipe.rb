class ChallengeRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :challenge
end
