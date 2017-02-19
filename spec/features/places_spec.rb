require 'rails_helper'
require 'beermapping_api'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if many are returned, they all are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kallio").and_return(
        [ Place.new( name:"Baari", id: 1 ) ,
          Place.new( name:"Pub", id: 2 ) ,
          Place.new( name:"Taverna", id: 3 ) ]
    )

    visit places_path
    fill_in('city', with: 'kallio')
    click_button "Search"

    expect(page).to have_content "Baari"
    expect(page).to have_content "Pub"
    expect(page).to have_content "Taverna"
  
end

  it "if none is returned, a message is shown" do
    allow(BeermappingApi).to receive(:places_in).with("kuu").and_return(
      [ ]
    )

    visit places_path
    fill_in('city', with: 'kuu')
    click_button "Search"

    expect(page).to have_content "No locations in kuu"
  end
    
end