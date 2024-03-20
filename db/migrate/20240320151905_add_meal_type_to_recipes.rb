class AddMealTypeToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :meal_type, :integer
  end
end
