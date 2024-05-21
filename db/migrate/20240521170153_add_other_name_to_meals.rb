class AddOtherNameToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :other_name, :string
  end
end
