require 'test_helper'

class UrbanImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @urban_image = urban_images(:one)
  end

  test "should get index" do
    get urban_images_url
    assert_response :success
  end

  test "should get new" do
    get new_urban_image_url
    assert_response :success
  end

  test "should create urban_image" do
    assert_difference('UrbanImage.count') do
      post urban_images_url, params: { urban_image: { city_id: @urban_image.city_id, name: @urban_image.name } }
    end

    assert_redirected_to urban_image_url(UrbanImage.last)
  end

  test "should show urban_image" do
    get urban_image_url(@urban_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_urban_image_url(@urban_image)
    assert_response :success
  end

  test "should update urban_image" do
    patch urban_image_url(@urban_image), params: { urban_image: { city_id: @urban_image.city_id, name: @urban_image.name } }
    assert_redirected_to urban_image_url(@urban_image)
  end

  test "should destroy urban_image" do
    assert_difference('UrbanImage.count', -1) do
      delete urban_image_url(@urban_image)
    end

    assert_redirected_to urban_images_url
  end
end
