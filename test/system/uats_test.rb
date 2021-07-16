require "application_system_test_case"

class UatsTest < ApplicationSystemTestCase
  setup do
    @uat = uats(:one)
  end

  test "visiting the index" do
    visit uats_url
    assert_selector "h1", text: "Uats"
  end

  test "creating a Uat" do
    visit uats_url
    click_on "New Uat"

    fill_in "No testing", with: @uat.no_testing
    fill_in "Penguji", with: @uat.penguji
    fill_in "Tgl testing", with: @uat.tgl_testing
    click_on "Create Uat"

    assert_text "Uat was successfully created"
    click_on "Back"
  end

  test "updating a Uat" do
    visit uats_url
    click_on "Edit", match: :first

    fill_in "No testing", with: @uat.no_testing
    fill_in "Penguji", with: @uat.penguji
    fill_in "Tgl testing", with: @uat.tgl_testing
    click_on "Update Uat"

    assert_text "Uat was successfully updated"
    click_on "Back"
  end

  test "destroying a Uat" do
    visit uats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Uat was successfully destroyed"
  end
end
