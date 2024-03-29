class RenameDateInMeal < ActiveRecord::Migration[7.1]
  def change
    rename_column :meals, :date, :start_time
    change_column :meals, :start_time, :datetime
  end
end
