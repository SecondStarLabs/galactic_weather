require 'test_helper'

class MartianWeatherStationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @martian_weather_station = martian_weather_stations(:one)
  end

  test "should get index" do
    get martian_weather_stations_url
    assert_response :success
  end

  test "should get new" do
    get new_martian_weather_station_url
    assert_response :success
  end

  test "should create martian_weather_station" do
    assert_difference('MartianWeatherStation.count') do
      post martian_weather_stations_url, params: { martian_weather_station: { latitude: @martian_weather_station.latitude, longitude: @martian_weather_station.longitude, name: @martian_weather_station.name } }
    end

    assert_redirected_to martian_weather_station_url(MartianWeatherStation.last)
  end

  test "should show martian_weather_station" do
    get martian_weather_station_url(@martian_weather_station)
    assert_response :success
  end

  test "should get edit" do
    get edit_martian_weather_station_url(@martian_weather_station)
    assert_response :success
  end

  test "should update martian_weather_station" do
    patch martian_weather_station_url(@martian_weather_station), params: { martian_weather_station: { latitude: @martian_weather_station.latitude, longitude: @martian_weather_station.longitude, name: @martian_weather_station.name } }
    assert_redirected_to martian_weather_station_url(@martian_weather_station)
  end

  test "should destroy martian_weather_station" do
    assert_difference('MartianWeatherStation.count', -1) do
      delete martian_weather_station_url(@martian_weather_station)
    end

    assert_redirected_to martian_weather_stations_url
  end
end
