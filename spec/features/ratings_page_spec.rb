require 'rails_helper'

include Helpers

describe "Ratings" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)
    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when there are ratings" do
    before :each do
      FactoryGirl.create :rating, user: user, beer: beer1, score:1
      FactoryGirl.create :rating, user: user, beer: beer2, score:2
      FactoryGirl.create :rating, user: user, beer: beer2, score:3
    end

    it "are in the ratings page" do
      visit ratings_path
      expect(page).to have_content "Number of ratings: 3"
      expect(page).to have_content "iso 3 1"
      expect(page).to have_content "Karhu 2"
      expect(page).to have_content "Karhu 2"
    end

    it "are on the raters page" do
      visit user_path(user)
      expect(page).to have_content "iso 3 1"
      expect(page).to have_content "Karhu 2"
      expect(page).to have_content "Karhu 2"
    end

    it "are deleted when user does so" do
      visit user_path(user)
      expect{
        page.all('a', text:'delete')[1].click
      }.to change{Rating.count}.by(-1)
    end
  end
end