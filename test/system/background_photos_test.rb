require "application_system_test_case"

class BackgroundPhotosTest < ApplicationSystemTestCase
  setup do
    @background_photo = background_photos(:one)
  end

  test "visiting the index" do
    visit background_photos_url
    assert_selector "h1", text: "Background Photos"
  end

  test "creating a Background photo" do
    visit background_photos_url
    click_on "New Background Photo"

    fill_in "Name", with: @background_photo.name
    fill_in "Source url", with: @background_photo.source_url
    click_on "Create Background photo"

    assert_text "Background photo was successfully created"
    click_on "Back"
  end

  test "updating a Background photo" do
    visit background_photos_url
    click_on "Edit", match: :first

    fill_in "Name", with: @background_photo.name
    fill_in "Source url", with: @background_photo.source_url
    click_on "Update Background photo"

    assert_text "Background photo was successfully updated"
    click_on "Back"
  end

  test "destroying a Background photo" do
    visit background_photos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Background photo was successfully destroyed"
  end
end
