class AddDescriptionToFamilies < ActiveRecord::Migration[7.1]
  def change
    add_column :families, :description, :string
  end
end
