require 'rails_helper'
require 'faker'

RSpec.describe 'user creation' do
  describe 'the user registration' do
    it 'renders the new form' do
      visit "/register"
      
      expect(page).to have_content('Register a New User')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Email')
      expect(find('form')).to have_content('Password')
      expect(find('form')).to have_content('Confirm password')
      expect(page).to have_button('Create New User')
    end

    it 'creates the user and redirects to the user show page' do
      visit "/register"

      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: "test123"
      fill_in 'Confirm password', with: "test123"

      click_button 'Create New User'
      
      expect(page).to have_current_path("/users/#{User.last.id}")
    end

    it 'gives warning for invalid data' do
      visit "/register"

      fill_in 'Name', with: ""
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: "test123"
      fill_in 'Confirm password', with: "test123"

      click_button 'Create New User'

      expect(page).to have_current_path("/register")
      expect(page).to have_content("Error: Name can't be blank")

      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: ""
      fill_in 'Password', with: "test123"
      fill_in 'Confirm password', with: "test123"

      click_button 'Create New User'

      expect(page).to have_current_path("/register")
      expect(page).to have_content("Error: Email can't be blank")

      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: "abc@yahoo.com"
      fill_in 'Password', with: "test123"
      fill_in 'Confirm password', with: "test123"

      click_button 'Create New User'

      visit "/register"

      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: "abc@yahoo.com"
      fill_in 'Password', with: "test123"
      fill_in 'Confirm password', with: "test123"

      click_button 'Create New User'

      expect(page).to have_content("Error: Email has already been taken")
    end

    it 'gives an error if your password dont match' do
      visit "/register"

      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: "abc@yahoo.com"
      fill_in 'Password', with: "test123"
      fill_in 'Confirm password', with: "YEAHRIGHT"

      click_button 'Create New User'

      expect(page).to have_content("Your passwords did not match. Please try again.")
    end
  end
end 