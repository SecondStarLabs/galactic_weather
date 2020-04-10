require "application_system_test_case"

class UrbanImagesTest < ApplicationSystemTestCase
  setup do
    @urban_image = urban_images(:one)
  end

  test "visiting the index" do
    visit urban_images_url
    assert_selector "h1", text: "Urban Images"
  end

  test "creating a Urban image" do
    visit urban_images_url
    click_on "New Urban Image"

    fill_in "City", with: @urban_image.city_id
    fill_in "Name", with: @urban_image.name
    click_on "Create Urban image"

    assert_text "Urban image was successfully created"
    click_on "Back"
  end

  test "updating a Urban image" do
    visit urban_images_url
    click_on "Edit", match: :first

    fill_in "City", with: @urban_image.city_id
    fill_in "Name", with: @urban_image.name
    click_on "Update Urban image"

    assert_text "Urban image was successfully updated"
    click_on "Back"
  end

  test "destroying a Urban image" do
    visit urban_images_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Urban image was successfully destroyed"
  end
end
