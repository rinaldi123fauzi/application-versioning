require "application_system_test_case"

class ApiTestsTest < ApplicationSystemTestCase
  setup do
    @api_test = api_tests(:one)
  end

  test "visiting the index" do
    visit api_tests_url
    assert_selector "h1", text: "Api Tests"
  end

  test "creating a Api test" do
    visit api_tests_url
    click_on "New Api Test"

    fill_in "Alamat", with: @api_test.alamat
    fill_in "Nama", with: @api_test.nama
    click_on "Create Api test"

    assert_text "Api test was successfully created"
    click_on "Back"
  end

  test "updating a Api test" do
    visit api_tests_url
    click_on "Edit", match: :first

    fill_in "Alamat", with: @api_test.alamat
    fill_in "Nama", with: @api_test.nama
    click_on "Update Api test"

    assert_text "Api test was successfully updated"
    click_on "Back"
  end

  test "destroying a Api test" do
    visit api_tests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Api test was successfully destroyed"
  end
end
