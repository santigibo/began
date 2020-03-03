class Category < ApplicationRecord
  has_many :users
  has_many :challenges

  has_one_attached :photo

  validates :name, presence: true
  validates :description, presence: true
end
