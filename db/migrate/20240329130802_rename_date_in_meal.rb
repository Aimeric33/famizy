class RenameDateInMeal < ActiveRecord::Migration[7.1]
  def change
    rename_column :meals, :date, :start_date
  end
end
