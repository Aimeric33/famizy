class RenameMealTypeInRecipes < ActiveRecord::Migration[7.1]
  def change
    rename_column :recipes, :meal_type, :recipe_type
  end
end
