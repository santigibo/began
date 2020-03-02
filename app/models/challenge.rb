class Challenge < ApplicationRecord
  belongs_to :category

  has_many :challenge_completions, dependent: :destroy
  has_many :users, through: :challenge_completions

  has_many :challenge_recipes, dependent: :destroy
  has_many :recipes, through: :challenge_recipes

  has_many :tips, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :position, presence: true
end
