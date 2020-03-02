class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :challenge_completions
  has_many :challenges, through: :challenge_completions

  has_many :user_recipes
  has_many :recipes, through: :user_recipes


  validates :first_name, presence: true
  validates :last_name, presence: true

  def fullname
    first_name + " " + last_name
  end
end
