# frozen_string_literal: true

RSpec.describe 'find drivers', type: :feature do
  it 'find by last name' do
    visit('/')
    click_on('Search drivers')
    fill_in('last_name', with: 'Kozlov')
    click_on('Search')
    expect(page).to have_content('Bus number: 98;' \
      ' Route number: 10;' \
      ' Petrol consumption: 3.5;' \
      ' Driver: Andrey Kozlov; Status: Work')
  end
end
