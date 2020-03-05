class Recipe < ApplicationRecord
  has_many :challenge_recipes
  has_many :challenges, through: :challenge_recipes

  has_many :user_recipes, dependent: :destroy
  has_many :users, through: :user_recipes

  has_many :ingredients
  has_many :recipe_methods

  has_one_attached :photo
end
