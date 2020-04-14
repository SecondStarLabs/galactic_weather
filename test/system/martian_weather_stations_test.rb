require "application_system_test_case"

class MartianWeatherStationsTest < ApplicationSystemTestCase
  setup do
    @martian_weather_station = martian_weather_stations(:one)
  end

  test "visiting the index" do
    visit martian_weather_stations_url
    assert_selector "h1", text: "Martian Weather Stations"
  end

  test "creating a Martian weather station" do
    visit martian_weather_stations_url
    click_on "New Martian Weather Station"

    fill_in "Latitude", with: @martian_weather_station.latitude
    fill_in "Longitude", with: @martian_weather_station.longitude
    fill_in "Name", with: @martian_weather_station.name
    click_on "Create Martian weather station"

    assert_text "Martian weather station was successfully created"
    click_on "Back"
  end

  test "updating a Martian weather station" do
    visit martian_weather_stations_url
    click_on "Edit", match: :first

    fill_in "Latitude", with: @martian_weather_station.latitude
    fill_in "Longitude", with: @martian_weather_station.longitude
    fill_in "Name", with: @martian_weather_station.name
    click_on "Update Martian weather station"

    assert_text "Martian weather station was successfully updated"
    click_on "Back"
  end

  test "destroying a Martian weather station" do
    visit martian_weather_stations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Martian weather station was successfully destroyed"
  end
end
