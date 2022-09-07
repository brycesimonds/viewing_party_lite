require 'rails_helper'

RSpec.describe 'user dashboard page' do
  it "has a email and password field" do
      visit "/login"

      expect(page).to have_content('Log In Page')
      expect(find('form')).to have_content('Email')
      expect(find('form')).to have_content('Password')

      expect(page).to have_button('Log In')
  end

  it "valid credentials bring the user to their dashboard" do
      visit "/login"
      user = User.create!(
        name: 'Bryce', 
        email: 'herewego@yahoo.com', 
        password: "test123")

      fill_in 'Email', with: "herewego@yahoo.com"
      fill_in 'Password', with: "test123"

      click_button 'Log In'
 
      expect(page).to have_current_path("/users/#{User.last.id}")
  end

  it "invalid credentials bring the user to the login page " do
      visit "/login"
      user = User.create!(
        name: 'Bryce', 
        email: 'herewego@yahoo.com', 
        password: "test123")

      fill_in 'Email', with: "herewego@yahoo.com"
      fill_in 'Password', with: "YEAHRIGHTYO"

      click_button 'Log In'

      expect(current_path).to eq("/login")
      expect(page).to have_content("Invalid credentials")
  end
end 