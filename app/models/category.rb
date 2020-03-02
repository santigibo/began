class Category < ApplicationRecord
  has_many :users
  has_many :challenges

  validates :name, presence: true
  validates :description, presence: true
end
