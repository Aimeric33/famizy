class Meal < ApplicationRecord
  belongs_to :family
  belongs_to :recipe

  enum meal_type: { lunch: 0, dinner: 1}

  validates :start_date, presence: true
  validates :recipe, presence: true
  validates :meal_type, presence: true
end
