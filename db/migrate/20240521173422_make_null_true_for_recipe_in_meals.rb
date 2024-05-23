class MakeNullTrueForRecipeInMeals < ActiveRecord::Migration[7.1]
  def change
    change_column_null :meals, :recipe_id, true
  end
end
