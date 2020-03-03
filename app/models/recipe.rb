class Recipe < ApplicationRecord
  has_many :challenge_recipes
  has_many :challenges, through: :challenge_recipes

  has_many :user_recipes
  has_many :users, through: :user_recipes

  has_one_attached :photo
end
