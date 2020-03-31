# frozen_string_literal: true

RSpec.describe 'route list', type: :feature do
  it 'show list of routes' do
    visit('/')
    click_on('Route list')
    expect(page).to have_content('Route number: 22; Route length: 30; Number of stops: 20; Required number of buses: 4')
  end

  it 'show detail of route' do
    visit('/')
    click_on('Route list')
    expect(page).to have_content('Route number: 10; Route length: 11; Number of stops: 12; Required number of buses: 6')
    click_on('route-10')
    expect(page).to have_content('There are not enough buses on this route!')
    expect(page).to have_content('Bus number: 98;' \
      ' Route number: 10; Petrol consumption: 3.5;' \
      ' Driver: Andrey Kozlov; Status: Work')
  end

  it 'add new route' do
    visit('/')
    click_on('Route list')
    click_on('Add route')
    fill_in('number', with: 5)
    fill_in('length', with: 30)
    fill_in('number_of_buses', with: 6)
    fill_in('number_of_stops', with: 13)
    click_on('Add new route')
    expect(page).to have_content('Route number: 5; Route length: 30; Number of stops: 13; Required number of buses: 6')
  end

  it 'print error when add new route' do
    visit('/')
    click_on('Route list')
    click_on('Add route')
    fill_in('number', with: 11)
    fill_in('length', with: -10)
    fill_in('number_of_buses', with: 0)
    fill_in('number_of_stops', with: -1)
    click_on('Add new route')
    expect(page).to have_content('A route with this number already exists')
    expect(page).to have_content('The length of the route can not be negative or equal to 0')
    expect(page).to have_content('The required number of buses on the route must be greater than 0')
    expect(page).to have_content('The number of stops must be greater than 0')
  end

  it 'delete route' do
    visit('/')
    click_on('Route list')
    expect(page).to have_content('Route number: 8; Route length: 12; Number of stops: 17; Required number of buses: 5')
    click_on('delete-8')
    expect(page).to have_content('Delete route №8')
    select(11, from: 'number_route')
    select('Stand', from: 'status')
    click_on('Delete route')
    expect(page).to have_no_content('Route number: 8;' \
      ' Route length: 12; Number of stops: 17;' \
      ' Required number of buses: 5')
    click_on('Bus list')
    expect(page).to have_content('Bus number: 101;' \
      ' Route number: 11; Petrol consumption: 2.9;' \
      ' Driver: Nikolay Serov; Status: Stand')
  end
end
