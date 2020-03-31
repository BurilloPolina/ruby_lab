# frozen_string_literal: true

RSpec.describe 'show petrol cost', type: :feature do
  it 'show list of petrol' do
    visit('/')
    click_on('Petrol consumption statistics')
    expect(page).to have_content('Total petrol consumption on all routes: ')
  end
end
