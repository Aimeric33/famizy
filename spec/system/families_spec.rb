require 'rails_helper'
require 'capybara_helper'

RSpec.describe "Family pages", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:family) { create(:family) }
  let(:user) { create(:user) }

  context "when not signed in" do
    it "doesn't allow a user to view a family" do
      visit family_path(family)
      expect(page).to have_content("Vous devez vous connecter")
    end
  end

  context "when signed in" do
    before do
      user.confirm
      sign_in user
      user.families << family
    end

    it "allows a user to view a family" do
      visit family_path(family)
      expect(page).to have_content(family.name)
    end

    it "allows a user to view all families" do
      visit families_path
      expect(page).to have_content("My families" && family.name)
    end

    it "allows a user to create a family" do
      visit families_path
      click_link "Créer une famille"
      fill_in "Nom", with: "Ma nouvelle famille"
      fill_in "Description", with: "Une description"
      click_button "Créer une famille"

      expect(page).to have_content("La famille a été créée avec succès.")
    end
  end
end
