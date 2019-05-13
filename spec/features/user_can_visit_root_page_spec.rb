require 'rails_helper'

feature "User can visit root page" do
  scenario "and view navbar contents" do
    visit "/"
    within(".navbar") do
      expect(page).to have_content("AltFuelFinder")
      expect(page).to have_selector("input[value='Search by zip...']")
    end
  end
  context "and fill in the search form with 80206" do
    scenario "and click Locate" do
      visit "/"
      fill_in "q", with: "80206"

      click_on "Locate"

      expect(current_path).to eq("/search")
      expect(page).to have_content("Stations: 93")
      expect(page).to have_css(".station", count: 15)
      within first(".station") do
        expect(page).to have_content("Name:")
        expect(page).to have_content("Address:")
        expect(page).to have_content("Fuel Types:")
        expect(page).to have_content("Distance:")
        expect(page).to have_content("Access Times:")
      end
      # Then I should see the total results of the stations that match my query, 90.
      # Then I should see a list of the 15 closest stations within 5 miles sorted by distance
      # And the stations should be limited to Electric and Propane
      # And the stations should only be public, and not private, planned or temporarily unavailable.
      # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
    end
  end
end
