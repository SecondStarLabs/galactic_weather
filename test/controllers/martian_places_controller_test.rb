require 'test_helper'

class MartianPlacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @martian_place = martian_places(:one)
  end

  test "should get index" do
    get martian_places_url
    assert_response :success
  end

  test "should get new" do
    get new_martian_place_url
    assert_response :success
  end

  test "should create martian_place" do
    assert_difference('MartianPlace.count') do
      post martian_places_url, params: { martian_place: { address: @martian_place.address, latitude: @martian_place.latitude, longitude: @martian_place.longitude, name: @martian_place.name } }
    end

    assert_redirected_to martian_place_url(MartianPlace.last)
  end

  test "should show martian_place" do
    get martian_place_url(@martian_place)
    assert_response :success
  end

  test "should get edit" do
    get edit_martian_place_url(@martian_place)
    assert_response :success
  end

  test "should update martian_place" do
    patch martian_place_url(@martian_place), params: { martian_place: { address: @martian_place.address, latitude: @martian_place.latitude, longitude: @martian_place.longitude, name: @martian_place.name } }
    assert_redirected_to martian_place_url(@martian_place)
  end

  test "should destroy martian_place" do
    assert_difference('MartianPlace.count', -1) do
      delete martian_place_url(@martian_place)
    end

    assert_redirected_to martian_places_url
  end
end
