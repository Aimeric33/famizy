class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.references :family, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
