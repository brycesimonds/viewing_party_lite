require 'rails_helper'

RSpec.describe 'user dashboard page' do
  it "has a email and password field" do
      visit "/login"

      expect(page).to have_content('Log In Page')
      expect(find('form')).to have_content('Email')
      expect(find('form')).to have_content('Password')

      expect(page).to have_button('Log In')
  end
end 