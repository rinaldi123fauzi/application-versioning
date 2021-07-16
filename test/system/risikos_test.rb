require "application_system_test_case"

class RisikosTest < ApplicationSystemTestCase
  setup do
    @risiko = risikos(:one)
  end

  test "visiting the index" do
    visit risikos_url
    assert_selector "h1", text: "Risikos"
  end

  test "creating a Risiko" do
    visit risikos_url
    click_on "New Risiko"

    fill_in "Deskripsi", with: @risiko.deskripsi
    fill_in "Nama", with: @risiko.nama
    click_on "Create Risiko"

    assert_text "Risiko was successfully created"
    click_on "Back"
  end

  test "updating a Risiko" do
    visit risikos_url
    click_on "Edit", match: :first

    fill_in "Deskripsi", with: @risiko.deskripsi
    fill_in "Nama", with: @risiko.nama
    click_on "Update Risiko"

    assert_text "Risiko was successfully updated"
    click_on "Back"
  end

  test "destroying a Risiko" do
    visit risikos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Risiko was successfully destroyed"
  end
end
