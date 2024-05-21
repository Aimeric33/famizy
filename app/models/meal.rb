class Meal < ApplicationRecord
  belongs_to :family
  belongs_to :recipe, optional: true

  enum meal_type: { lunch: 0, dinner: 1}

  validates :date, presence: true
  validates :recipe, presence: true, unless: -> { other_name.present? }
  validates :other_name, presence: true, unless: -> { recipe.present? }
  validates :meal_type, presence: true

  def self.meals_this_week(family)
    where(family: family, date: Date.today.beginning_of_week..Date.today.end_of_week)
  end
end
