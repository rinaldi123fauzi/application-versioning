require "application_system_test_case"

class InternalsTest < ApplicationSystemTestCase
  setup do
    @internal = internals(:one)
  end

  test "visiting the index" do
    visit internals_url
    assert_selector "h1", text: "Internals"
  end

  test "creating a Internal" do
    visit internals_url
    click_on "New Internal"

    fill_in "Penguji", with: @internal.penguji
    fill_in "Tgl testing", with: @internal.tgl_testing
    click_on "Create Internal"

    assert_text "Internal was successfully created"
    click_on "Back"
  end

  test "updating a Internal" do
    visit internals_url
    click_on "Edit", match: :first

    fill_in "Penguji", with: @internal.penguji
    fill_in "Tgl testing", with: @internal.tgl_testing
    click_on "Update Internal"

    assert_text "Internal was successfully updated"
    click_on "Back"
  end

  test "destroying a Internal" do
    visit internals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Internal was successfully destroyed"
  end
end
