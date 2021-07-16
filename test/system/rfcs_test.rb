require "application_system_test_case"

class RfcsTest < ApplicationSystemTestCase
  setup do
    @rfc = rfcs(:one)
  end

  test "visiting the index" do
    visit rfcs_url
    assert_selector "h1", text: "Rfcs"
  end

  test "creating a Rfc" do
    visit rfcs_url
    click_on "New Rfc"

    fill_in "Link", with: @rfc.link
    fill_in "No registrasi perubahan", with: @rfc.no_registrasi_perubahan
    fill_in "Tanggal", with: @rfc.tanggal
    fill_in "Uraian perubahan", with: @rfc.uraian_perubahan
    fill_in "Versi aplikasi", with: @rfc.versi_aplikasi
    click_on "Create Rfc"

    assert_text "Rfc was successfully created"
    click_on "Back"
  end

  test "updating a Rfc" do
    visit rfcs_url
    click_on "Edit", match: :first

    fill_in "Link", with: @rfc.link
    fill_in "No registrasi perubahan", with: @rfc.no_registrasi_perubahan
    fill_in "Tanggal", with: @rfc.tanggal
    fill_in "Uraian perubahan", with: @rfc.uraian_perubahan
    fill_in "Versi aplikasi", with: @rfc.versi_aplikasi
    click_on "Update Rfc"

    assert_text "Rfc was successfully updated"
    click_on "Back"
  end

  test "destroying a Rfc" do
    visit rfcs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rfc was successfully destroyed"
  end
end
