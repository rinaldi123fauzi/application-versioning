require "application_system_test_case"

class PrioritiesTest < ApplicationSystemTestCase
  setup do
    @priority = priorities(:one)
  end

  test "visiting the index" do
    visit priorities_url
    assert_selector "h1", text: "Priorities"
  end

  test "creating a Priority" do
    visit priorities_url
    click_on "New Priority"

    fill_in "Deskripsi", with: @priority.deskripsi
    fill_in "Nama", with: @priority.nama
    click_on "Create Priority"

    assert_text "Priority was successfully created"
    click_on "Back"
  end

  test "updating a Priority" do
    visit priorities_url
    click_on "Edit", match: :first

    fill_in "Deskripsi", with: @priority.deskripsi
    fill_in "Nama", with: @priority.nama
    click_on "Update Priority"

    assert_text "Priority was successfully updated"
    click_on "Back"
  end

  test "destroying a Priority" do
    visit priorities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Priority was successfully destroyed"
  end
end
