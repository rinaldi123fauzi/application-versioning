require "application_system_test_case"

class AplikasisTest < ApplicationSystemTestCase
  setup do
    @aplikasi = aplikasis(:one)
  end

  test "visiting the index" do
    visit aplikasis_url
    assert_selector "h1", text: "Aplikasis"
  end

  test "creating a Aplikasi" do
    visit aplikasis_url
    click_on "New Aplikasi"

    fill_in "Deskripsi", with: @aplikasi.deskripsi
    fill_in "Id aplikasi", with: @aplikasi.id_aplikasi
    fill_in "Kode", with: @aplikasi.kode
    fill_in "Nama aplikasi", with: @aplikasi.nama_aplikasi
    fill_in "Pemilik proses", with: @aplikasi.pemilik_proses
    click_on "Create Aplikasi"

    assert_text "Aplikasi was successfully created"
    click_on "Back"
  end

  test "updating a Aplikasi" do
    visit aplikasis_url
    click_on "Edit", match: :first

    fill_in "Deskripsi", with: @aplikasi.deskripsi
    fill_in "Id aplikasi", with: @aplikasi.id_aplikasi
    fill_in "Kode", with: @aplikasi.kode
    fill_in "Nama aplikasi", with: @aplikasi.nama_aplikasi
    fill_in "Pemilik proses", with: @aplikasi.pemilik_proses
    click_on "Update Aplikasi"

    assert_text "Aplikasi was successfully updated"
    click_on "Back"
  end

  test "destroying a Aplikasi" do
    visit aplikasis_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Aplikasi was successfully destroyed"
  end
end
