require "application_system_test_case"

class PenyelesaiansTest < ApplicationSystemTestCase
  setup do
    @penyelesaian = penyelesaians(:one)
  end

  test "visiting the index" do
    visit penyelesaians_url
    assert_selector "h1", text: "Penyelesaians"
  end

  test "creating a Penyelesaian" do
    visit penyelesaians_url
    click_on "New Penyelesaian"

    fill_in "Durasi", with: @penyelesaian.durasi
    fill_in "Kode penyelesaian", with: @penyelesaian.kode_penyelesaian
    fill_in "Pic", with: @penyelesaian.pic
    fill_in "Tgl selesai", with: @penyelesaian.tgl_selesai
    click_on "Create Penyelesaian"

    assert_text "Penyelesaian was successfully created"
    click_on "Back"
  end

  test "updating a Penyelesaian" do
    visit penyelesaians_url
    click_on "Edit", match: :first

    fill_in "Durasi", with: @penyelesaian.durasi
    fill_in "Kode penyelesaian", with: @penyelesaian.kode_penyelesaian
    fill_in "Pic", with: @penyelesaian.pic
    fill_in "Tgl selesai", with: @penyelesaian.tgl_selesai
    click_on "Update Penyelesaian"

    assert_text "Penyelesaian was successfully updated"
    click_on "Back"
  end

  test "destroying a Penyelesaian" do
    visit penyelesaians_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Penyelesaian was successfully destroyed"
  end
end
