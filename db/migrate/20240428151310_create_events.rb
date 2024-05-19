class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.boolean :full_day, default: false
      t.datetime :start_date
      t.datetime :end_date
      t.string :place
      t.text :description
      t.string :color, default: "blue"
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
