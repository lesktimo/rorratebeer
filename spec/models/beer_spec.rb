require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:brewery1){ Brewery.new name:"Test Brewery", year:1779 }
  it "is saved with proper name and style" do
  	beer = Beer.create name:"Olunen", style:"IPA", brewery:brewery1
  	expect(beer).to be_valid
  	expect(Beer.count).to eq(1)
  end
  describe "is not saved" do
  	it "without a proper name"do
  		beer = Beer.create name:"", style:"IPA", brewery:brewery1
  		expect(beer).not_to be_valid
  		expect(Beer.count).to eq(0)
  	end
  	it "without a proper style"do
  		beer = Beer.create name:"Olunen", style:"", brewery:brewery1
  		expect(beer).not_to be_valid
  		expect(Beer.count).to eq(0)
  	end
  end
end
