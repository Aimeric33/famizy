class AddSlugToFamilies < ActiveRecord::Migration[7.1]
  def change
    add_column :families, :slug, :string
    add_index :families, :slug, unique: true
  end
end
