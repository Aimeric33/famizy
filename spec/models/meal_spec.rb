require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe "validations" do
    it "is valid with recipe reference" do
      meal = build(:meal, other_name: nil)

      expect(meal).to be_valid
    end

    it "is valid with other_name" do
      meal = build(:meal, recipe: nil, other_name: "Other")

      expect(meal).to be_valid
    end

    it "is invalid without recipe reference or other_name" do
      meal = build(:meal, recipe: nil, other_name: nil)

      expect(meal).to be_invalid
    end
  end

  describe "#meals_this_week" do
    it "returns meals for the current week only" do
      family = create(:family)
      meal1 = create(:meal, family: family, date: Date.today.beginning_of_week)
      meal2 = create(:meal, family: family, date: Date.today.end_of_week)
      meal3 = create(:meal, family: family, date: Date.today.beginning_of_week - 1.day)
      meal4 = create(:meal, family: family, date: Date.today.end_of_week + 1.day)

      expect(Meal.meals_this_week(family)).to include(meal1, meal2)
      expect(Meal.meals_this_week(family)).not_to include(meal3, meal4)
    end
  end
end
