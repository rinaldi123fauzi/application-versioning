require "application_system_test_case"

class MainResponsibilitiesTest < ApplicationSystemTestCase
  setup do
    @main_responsibility = main_responsibilities(:one)
  end

  test "visiting the index" do
    visit main_responsibilities_url
    assert_selector "h1", text: "Main Responsibilities"
  end

  test "creating a Main responsibility" do
    visit main_responsibilities_url
    click_on "New Main Responsibility"

    fill_in "Aktivitas", with: @main_responsibility.aktivitas
    fill_in "Frekuensi", with: @main_responsibility.frekuensi
    fill_in "Menit", with: @main_responsibility.menit
    fill_in "Output", with: @main_responsibility.output
    fill_in "Periode", with: @main_responsibility.periode
    fill_in "Staff", with: @main_responsibility.staff_id
    fill_in "Tanggung jawab utama", with: @main_responsibility.tanggung_jawab_utama
    click_on "Create Main responsibility"

    assert_text "Main responsibility was successfully created"
    click_on "Back"
  end

  test "updating a Main responsibility" do
    visit main_responsibilities_url
    click_on "Edit", match: :first

    fill_in "Aktivitas", with: @main_responsibility.aktivitas
    fill_in "Frekuensi", with: @main_responsibility.frekuensi
    fill_in "Menit", with: @main_responsibility.menit
    fill_in "Output", with: @main_responsibility.output
    fill_in "Periode", with: @main_responsibility.periode
    fill_in "Staff", with: @main_responsibility.staff_id
    fill_in "Tanggung jawab utama", with: @main_responsibility.tanggung_jawab_utama
    click_on "Update Main responsibility"

    assert_text "Main responsibility was successfully updated"
    click_on "Back"
  end

  test "destroying a Main responsibility" do
    visit main_responsibilities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Main responsibility was successfully destroyed"
  end
end
