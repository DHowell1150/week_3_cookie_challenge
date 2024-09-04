require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(username: "funbucket13", password: "test")

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.username}")
  end

  it "saves location as a cookie upon login" do 
    user = User.create(username: "funbucket13", password: "test")
  
    # we don't have to go through root_path and click the "I have an account" link any more
    visit login_path
  
    fill_in :username, with: user.username
    fill_in :password, with: user.password
    fill_in :location, with: "Denver, CO"
  
    click_on "Log In"
  
    expect(current_path).to eq(root_path)

    expect(page).to have_content("Location: Denver, CO")
  
# when I log in successfully
# and then leave the website and navigate to a different website entirely,
# Then when I return to *this* website, 
# I see that I am still logged in. 

  end
  it "cannot log in with bad credentials" do
    user = User.create(username: "funbucket13", password: "test")
  
    # we don't have to go through root_path and click the "I have an account" link any more
    visit login_path
  
    fill_in :username, with: user.username
    fill_in :password, with: "incorrect password"
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end