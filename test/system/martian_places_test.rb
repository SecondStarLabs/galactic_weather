require "application_system_test_case"

class MartianPlacesTest < ApplicationSystemTestCase
  setup do
    @martian_place = martian_places(:one)
  end

  test "visiting the index" do
    visit martian_places_url
    assert_selector "h1", text: "Martian Places"
  end

  test "creating a Martian place" do
    visit martian_places_url
    click_on "New Martian Place"

    fill_in "Address", with: @martian_place.address
    fill_in "Latitude", with: @martian_place.latitude
    fill_in "Longitude", with: @martian_place.longitude
    fill_in "Name", with: @martian_place.name
    click_on "Create Martian place"

    assert_text "Martian place was successfully created"
    click_on "Back"
  end

  test "updating a Martian place" do
    visit martian_places_url
    click_on "Edit", match: :first

    fill_in "Address", with: @martian_place.address
    fill_in "Latitude", with: @martian_place.latitude
    fill_in "Longitude", with: @martian_place.longitude
    fill_in "Name", with: @martian_place.name
    click_on "Update Martian place"

    assert_text "Martian place was successfully updated"
    click_on "Back"
  end

  test "destroying a Martian place" do
    visit martian_places_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Martian place was successfully destroyed"
  end
end
