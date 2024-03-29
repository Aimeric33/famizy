class AddMealTypeToMeal < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :meal_type, :integer
  end
end
