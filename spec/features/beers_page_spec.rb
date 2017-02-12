require 'rails_helper'

include Helpers
 
describe "Beer" do
	before :each do
		FactoryGirl.create :brewery
		visit new_beer_path
	end

	it "is added with a valid name" do
		fill_in('beer_name', with:'Stallhagen')
		select('IPA', from:'beer[style]')
		expect{
        click_button "Create Beer"
      }.to change{Beer.count}.from(0).to(1)
	end

	it "is not added without a valid name" do
 		click_button('Create Beer')
 		expect(page).to have_content "Name can't be blank"
 		expect(Beer.count).to be(0)
	end
end