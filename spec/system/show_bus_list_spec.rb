# frozen_string_literal: true

RSpec.describe 'bus list', type: :feature do
  it 'show bus' do
    visit('/')
    expect(page).to have_content('Bus list')
  end

  it 'set new params' do
    visit('/')
    click_on('set-bus-348')
    expect(page).to have_content('Change bus parameters #348')
    select(10, from: 'number_route')
    select('Work', from: 'status')
    click_on('Submit')
    expect(page).to have_content('Bus number: 348;' \
      ' Route number: 10; Petrol consumption: 2.8;' \
      ' Driver: Pavel Petrov; Status: Work')
  end

  it 'add new bus' do
    visit('/')
    click_on('Add bus')
    fill_in('number_bus', with: 13)
    select(22, from: 'number_route')
    fill_in('first_name', with: 'Petr')
    fill_in('last_name', with: 'Petrov')
    fill_in('petrol', with: 3.2)
    select('Work', from: 'status')
    click_on('Add new bus')
    expect(page).to have_content('Bus number: 13;' \
      ' Route number: 22;' \
      ' Petrol consumption: 3.2;' \
      ' Driver: Petr Petrov; Status: Work')
  end

  it 'print errors when add new bus' do
    visit('/')
    click_on('Add bus')
    fill_in('number_bus', with: -10)
    select(11, from: 'number_route')
    fill_in('first_name', with: 'Petr')
    fill_in('last_name', with: 'Petr0v')
    fill_in('petrol', with: -0.2)
    select('Work', from: 'status')
    click_on('Add new bus')
    expect(page).to have_content('Bus number must be greater than 0')
    expect(page).to have_content('Driver last name may contain only letters')
    expect(page).to have_content('Petrol consumption cannot be negative or equal to 0')
  end

  it 'delete bus' do
    visit('/')
    click_on('delete-bus-123')
    expect(page).to have_no_content('Bus number: 123;' \
      ' Route number: 22;' \
      ' Petrol consumption: 3.4;' \
      ' Driver: Ivan Ivanov; Status: Work')
  end
end
