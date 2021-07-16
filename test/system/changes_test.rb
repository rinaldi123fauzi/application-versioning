require "application_system_test_case"

class ChangesTest < ApplicationSystemTestCase
  setup do
    @change = changes(:one)
  end

  test "visiting the index" do
    visit changes_url
    assert_selector "h1", text: "Changes"
  end

  test "creating a Change" do
    visit changes_url
    click_on "New Change"

    fill_in "Pemilik proses", with: @change.pemilik_proses
    fill_in "Tgl release", with: @change.tgl_release
    fill_in "Versi sourcecode", with: @change.versi_sourcecode
    click_on "Create Change"

    assert_text "Change was successfully created"
    click_on "Back"
  end

  test "updating a Change" do
    visit changes_url
    click_on "Edit", match: :first

    fill_in "Pemilik proses", with: @change.pemilik_proses
    fill_in "Tgl release", with: @change.tgl_release
    fill_in "Versi sourcecode", with: @change.versi_sourcecode
    click_on "Update Change"

    assert_text "Change was successfully updated"
    click_on "Back"
  end

  test "destroying a Change" do
    visit changes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Change was successfully destroyed"
  end
end
