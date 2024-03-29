class CreateLists < ActiveRecord::Migration[7.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :list_type
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
