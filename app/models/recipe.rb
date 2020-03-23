class Recipe < ApplicationRecord
  has_many :challenge_recipes, dependent: :destroy
  has_many :challenges, through: :challenge_recipes

  has_many :user_recipes, dependent: :destroy
  has_many :users, through: :user_recipes

  has_many :ingredients, dependent: :destroy
  has_many :recipe_methods, dependent: :destroy

  has_one_attached :photo
end
