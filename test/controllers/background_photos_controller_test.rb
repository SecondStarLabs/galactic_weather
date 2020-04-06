require 'test_helper'

class BackgroundPhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @background_photo = background_photos(:one)
  end

  test "should get index" do
    get background_photos_url
    assert_response :success
  end

  test "should get new" do
    get new_background_photo_url
    assert_response :success
  end

  test "should create background_photo" do
    assert_difference('BackgroundPhoto.count') do
      post background_photos_url, params: { background_photo: { name: @background_photo.name, source_url: @background_photo.source_url } }
    end

    assert_redirected_to background_photo_url(BackgroundPhoto.last)
  end

  test "should show background_photo" do
    get background_photo_url(@background_photo)
    assert_response :success
  end

  test "should get edit" do
    get edit_background_photo_url(@background_photo)
    assert_response :success
  end

  test "should update background_photo" do
    patch background_photo_url(@background_photo), params: { background_photo: { name: @background_photo.name, source_url: @background_photo.source_url } }
    assert_redirected_to background_photo_url(@background_photo)
  end

  test "should destroy background_photo" do
    assert_difference('BackgroundPhoto.count', -1) do
      delete background_photo_url(@background_photo)
    end

    assert_redirected_to background_photos_url
  end
end
