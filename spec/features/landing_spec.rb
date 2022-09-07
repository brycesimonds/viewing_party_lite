require 'rails_helper'

RSpec.describe 'landing page' do

  describe 'ALL landing page functionality' do
    it "can display the apps name" do
      visit '/'

      expect(page).to have_content('Viewing Party Lite')
    end

    it "has a button to create a new user" do
      visit '/'

      expect(page).to have_button('Create a New User')
      click_button('Create a New User')
      expect(current_path).to eq('/register')
    end

    it "displays existing user emails only" do
      user1 = User.create!(name: 'Hai Sall', email: 'shoe_eater@payless.com', password: "test123")
      user2 = User.create!(name: 'Sryce Bimmons', email: 'valhiemhero@hotmail.com', password: "test123")

      visit '/'

      expect(page).to have_content('shoe_eater@payless.com')
      expect(page).to have_content('valhiemhero@hotmail.com')
      expect(page).to_not have_content('Hai Sall')
      expect(page).to_not have_content('Sryce Bimmons')
    end

    it "links existing users to the user dashboard" do
      user1 = User.create!(name: 'Hai Sall', email: 'shoe_eater@payless.com', password: "test123")
      user2 = User.create!(name: 'Sryce Bimmons', email: 'valhiemhero@hotmail.com', password: "test123")

      visit '/'
      click_link("shoe_eater@payless.com's Dashboard")
      expect(current_path).to eq("/users/#{user1.id}")

      visit '/'
      click_link("valhiemhero@hotmail.com's Dashboard")
      expect(current_path).to eq("/users/#{user2.id}")
    end

    it "has a link to the home page" do
      visit '/'

      expect(page).to have_link('Home')
      click_link('Home')
      expect(current_path).to eq('/')
    end
    
    it 'has a link for a log in' do 
      visit '/' 

      expect(page).to have_link("Log In")

      click_link "Log In"

      expect(current_path).to eq('/login')
    end

    it 'does not show a link to log in or creat an account if the user is logged in' do
      user = User.create!(name: 'Hai Sall', email: 'shoe_eater@payless.com', password: "test123")
      visit '/login' 

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      visit '/'

      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Create a New User")
    end

    it 'as a signed in user it shows the log out link' do
      user = User.create!(name: 'Hai Sall', email: 'shoe_eater@payless.com', password: "test123")
      visit '/login' 

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      visit '/'

      expect(page).to have_link("Log Out")
    end

    it 'clicking sign out brings user to landing page and there is a log in link' do
      user = User.create!(name: 'Hai Sall', email: 'shoe_eater@payless.com', password: "test123")
      visit '/login' 

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      visit '/'

      click_link 'Log Out'
   
      expect(page).to have_link("Log In")
    end

    it 'throws an error if a user tried to access the dashboard without being logged in' do
      user = User.create!(name: 'Hai Sall', email: 'shoe_eater@payless.com', password: "test123")

      visit '/'
      click_on "#{user.email}'s Dashboard"
      expect(page).to have_content("ERROR")
    end
  end
end
