require 'rails_helper'

feature "User can search alt fuel stations nearby" do
  scenario "and view navbar contents" do
    # As a user
    # When I visit "/"
    visit "/"

    # And I fill in the search form with 80206 (Note: Use the existing search form)
    # And I click "Locate"
    within(".navbar") do
      fill_in 'q', with: '80206'
      click_on 'Locate'
    end

    # Then I should be on page "/search"
    expect(current_path).to eq('/search')

    # Then I should see the total results of the stations that match my query, 90.
    expect(page).to have_content('Total Results: 93')

    # Then I should see a list of the 15 closest stations within 5 miles sorted by distance
    expect(page).to have_css('.nearby-station', count: 15)

    # And the stations should be limited to Electric and Propane
    # And the stations should only be public, and not private, planned or temporarily unavailable.
    # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
    # You will be using this documentation: https://developer.nrel.gov/docs/transportation/alt-fuel-stations-v1/nearest/
  end
end
