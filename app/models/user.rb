class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :challenge_completions
  has_many :challenges, through: :challenge_completions

  # belongs_to :categories
  # validates :categories, length: { minimum: 0, maximum: 1 }

  has_many :user_recipes
  has_many :recipes, through: :user_recipes

  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true

  def fullname
    first_name + " " + last_name
  end
end
