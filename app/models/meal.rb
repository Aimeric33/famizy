class Meal < ApplicationRecord
  belongs_to :family
  belongs_to :recipe

  validates :date, presence: true
  validates :recipe, presence: true
  validates :meal_type, presence: true
end
